#!/bin/bash
CACHE=/tmp/waybar_ports_cache
TTL=10

if [[ -f "$CACHE" ]] && [[ $(($(date +%s) - $(stat -c %Y "$CACHE" 2>/dev/null || echo 0))) -lt $TTL ]]; then
    cat "$CACHE"
    exit 0
fi

output=$(timeout 2 ss -tln 2>/dev/null)
if [[ -z "$output" ]]; then
    echo ""
    exit 0
fi

echo "$output" | awk 'NR>1 {
    split($4, a, ":");
    port = a[length(a)]+0;
    if (port >= 3000 && !(port in seen)) {
        seen[port]=1;
        ports[++n]=port;
    }
}
END {
    for (i=1; i<=n && i<=6; i++) {
        p=ports[i];
        if (p >= 7000) buf = substr(p,1,1) "g";
        else buf = sprintf("%02d", p%100);
        out = out (i>1 ? " " : "") buf;
    }
    print out;
}'
