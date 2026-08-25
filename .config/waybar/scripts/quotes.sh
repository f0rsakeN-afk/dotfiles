#!/usr/bin/env bash

QUOTES=(
  # calm / panic control
  "Nothing is wrong. I'm learning."
  "Slow is smooth. Smooth is fast."
  "Pause. Breathe. Continue."
  "This moment is safe."
  "I respond, not react."
  "Urgency is optional."
  "Calm is a skill."

  # discipline / control
  "Control beats intensity."
  "Stay cold. Stay precise."
  "Silence, then action."
  "Focus is power."
  "No reaction. Just execution."
  "Energy follows attention."

  # focus / consistency
  "One task. Finish it."
  "Small commits compound."
  "Progress over perfection."
  "Just show up today."
  "Momentum beats motivation."
  "Finish > perfect."

  # learning / web3
  "Confusion means growth."
  "Every bug teaches me."
  "Learn. Build. Repeat."
  "Understanding takes reps."
  "Temporary confusion. Permanent skill."
  "Builders win."

  # resilience
  "This phase ends."
  "I don't quit on hard days."
  "Discomfort is training."
  "Feel it. Move forward."
  "I've survived worse days."

  # identity
  "I finish what I start."
  "I'm becoming capable."
  "Future me is watching."
  "Calm is my advantage."
  "I build even when messy."
)

COUNT=${#QUOTES[@]}

# change quote every hour (based on current hour)
HOUR=$(date +%H)
INDEX=$((HOUR % COUNT))

echo "${QUOTES[$INDEX]}"

