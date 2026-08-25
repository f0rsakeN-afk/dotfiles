#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <vector>
#include <dirent.h>
#include <unistd.h>
#include <time.h>
#include <sys/stat.h>

static int hex2i(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    return 0;
}
static unsigned short hex_port(const char* a) {
    int l = strlen(a);
    const char* p = a + l - 4;
    return (unsigned short)((hex2i(p[0])<<12)|(hex2i(p[1])<<8)|(hex2i(p[2])<<4)|hex2i(p[3]));
}

struct ListenPort { int inode; unsigned short port; };

static char proc_prefix(const char* comm) {
    if (!comm) return 0;
    if (strstr(comm,"node")) return 'n';
    if (strstr(comm,"next")||strstr(comm,"vite")||strstr(comm,"nuxt")||strstr(comm,"remix")||strstr(comm,"astro")) return 'n';
    if (strstr(comm,"python")||strstr(comm,"uvicorn")||strstr(comm,"fastapi")||strstr(comm,"flask")||strstr(comm,"django")) return 'p';
    if (strstr(comm,"java")||strstr(comm,"gradle")) return 'j';
    if (strstr(comm,"go")||strstr(comm,"air")) return 'g';
    if (strstr(comm,"rust")||strstr(comm,"cargo")) return 'r';
    if (strstr(comm,"php")||strstr(comm,"laravel")||strstr(comm,"composer")) return 'x';
    if (strstr(comm,"ruby")||strstr(comm,"rails")||strstr(comm,"puma")) return 'b';
    if (strstr(comm,"nginx")||strstr(comm,"httpd")||strstr(comm,"apache")) return 'w';
    if (strstr(comm,"postgres")||strstr(comm,"mysql")||strstr(comm,"mariadb")) return 'd';
    if (strstr(comm,"redis")||strstr(comm,"memcached")) return 'R';
    if (strstr(comm,"docker")||strstr(comm,"containerd")) return 'D';
    if (strstr(comm,"sshd")) return 's';
    if (strstr(comm,"tailscale")) return 't';
    if (strstr(comm,"minio")) return 'm';
    if (strstr(comm,"code")||strstr(comm,"cursor")||strstr(comm,"code-oss")) return 'e';
    return 0;
}

static const char* CACHE = "/tmp/waybar_ports_v2";
static const int TTL = 10;

int main() {
    // Check cache
    struct stat st;
    if (stat(CACHE, &st) == 0 && time(NULL) - st.st_mtime < TTL) {
        FILE* c = fopen(CACHE, "r");
        if (c) {
            char buf[256];
            size_t n = fread(buf, 1, sizeof(buf)-1, c);
            if (n) { buf[n] = 0; fputs(buf, stdout); }
            fclose(c);
            return 0;
        }
    }

    // Pass 1: collect all listening (inode, port) from /proc/net/{tcp,tcp6,udp,udp6}
    std::vector<ListenPort> listening;
    const char* netfiles[] = {"/proc/net/tcp","/proc/net/tcp6","/proc/net/udp","/proc/net/udp6"};
    for (int f = 0; f < 4; f++) {
        FILE* fp = fopen(netfiles[f], "r");
        if (!fp) continue;
        char line[256];
        fgets(line, sizeof(line), fp); // skip header
        while (fgets(line, sizeof(line), fp)) {
            unsigned short port; int inode; char state[16];
            if (sscanf(line, "%*d: %*x:%hx %*x %15s %*x:%*x %*x:%*x %*d %*d %d",
                       &port, state, &inode) == 3) {
                if (strcmp(state, "0A") == 0 && port >= 3000) {
                    listening.push_back({inode, port});
                }
            }
        }
        fclose(fp);
    }

    // Pass 2: scan /proc/PID/fd for socket inodes matching our ports
    struct Result { unsigned short port; char prefix; };
    std::vector<Result> results;

    DIR* proc = opendir("/proc");
    if (!proc) return 1;
    struct dirent* de;
    while ((de = readdir(proc))) {
        if (de->d_type != DT_DIR) continue;
        int pid = atoi(de->d_name);
        if (pid <= 0) continue;

        char comm_path[64], fd_path[64];
        snprintf(comm_path, sizeof(comm_path), "/proc/%d/comm", pid);
        snprintf(fd_path, sizeof(fd_path), "/proc/%d/fd", pid);

        FILE* cf = fopen(comm_path, "r");
        char comm[256] = {0};
        if (cf) { fgets(comm, sizeof(comm), cf); fclose(cf); }
        char* cp = strchr(comm, '\n'); if (cp) *cp = 0;

        char pref = proc_prefix(comm);
        if (!pref) continue;

        DIR* fd_dir = opendir(fd_path);
        if (!fd_dir) continue;
        struct dirent* fde;
        while ((fde = readdir(fd_dir))) {
            char link[512];
            char link_path[128];
            snprintf(link_path, sizeof(link_path), "%s/%s", fd_path, fde->d_name);
            ssize_t l = readlink(link_path, link, sizeof(link)-1);
            if (l <= 0) continue;
            link[l] = 0;
            if (strncmp(link, "socket:[", 8) != 0) continue;
            int inode = atoi(link + 8);

            for (const auto& lp : listening) {
                if (lp.inode != inode) continue;
                bool dup = false;
                for (const auto& r : results) if (r.port == lp.port) { dup = true; break; }
                if (!dup) results.push_back({(unsigned short)lp.port, pref});
                break;
            }
        }
        closedir(fd_dir);
    }
    closedir(proc);

    // Format output
    char out[512] = {0};
    for (size_t i = 0; i < results.size() && i < 6; i++) {
        char buf[16];
        int p = results[i].port;
        if (p >= 7000) snprintf(buf, sizeof(buf), "%c%dg", results[i].prefix, p/1000);
        else snprintf(buf, sizeof(buf), "%c%02d", results[i].prefix, p%100);
        if (i > 0) strncat(out, " ", sizeof(out)-strlen(out)-1);
        strncat(out, buf, sizeof(out)-strlen(out)-1);
    }

    FILE* c = fopen(CACHE, "w");
    if (c) { fputs(out, c); fclose(c); }
    printf("%s", out);
    return 0;
}
