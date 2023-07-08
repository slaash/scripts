#!/bin/bash

diceArt=("9" "10" "J" "Q" "K" "A")

genHand() {
    local n=$1
    hand=()
    for ((d=0; d<n; d++)); do
        r=$((RANDOM % 6 + 1))
        hand+=("$r")
    done
    echo "${hand[@]}"
}

showHand() {
    local hand=("$@")
    artHand=()
    for d in "${hand[@]}"; do
        artHand+=("${diceArt[d-1]}")
    done
    c=1
    for a in "${artHand[@]}"; do
        printf "%s) %s\t" "$c" "$a"
        ((c++))
    done
    printf "\n"
}

for ((p=0; p<2; p++)); do
    hand=$(genHand 5)
    for ((h=0; h<3; h++)); do
        printf "Player %d, hand %d\n" "$((p+1))" "$((h+1))"
        showHand $hand
        diceToKeep=()
        read -p "  What to keep (comma-separated list of dice (1-5) or null for exit)? " choice
        choice="${choice// /}"
        IFS=',' read -ra opts <<< "$choice"
        if [[ ${#opts[@]} -eq 0 || ${opts[0]} == '' ]]; then
            break
        fi
        for opt in "${opts[@]}"; do
            diceToKeep+=("${hand[opt-1]}")
        done
        shortHand=$(genHand $((5 - ${#diceToKeep[@]})))
        hand=("${shortHand[@]}" "${diceToKeep[@]}")
    done
    printf "Player %d, final hand\n" "$((p+1))"
    showHand $hand
done
