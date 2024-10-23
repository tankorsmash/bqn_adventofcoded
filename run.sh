#!/bin/bash

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 YEAR DAY"
    exit 1
fi

YEAR=$1
DAY=$2

# Validate that both arguments are integers
if ! [[ "$YEAR" =~ ^[0-9]+$ ]] || ! [[ "$DAY" =~ ^[0-9]+$ ]]; then
    echo "Error: YEAR and DAY must be integers."
    exit 1
fi

# Run the watch command with the provided YEAR and DAY
# watch -n 0.05 ~/langs/bqn/CBQN/BQN src/"$YEAR"/day"$DAY".bqn
watchexec -c -- ~/langs/bqn/CBQN/BQN src/"$YEAR"/day"$DAY".bqn
