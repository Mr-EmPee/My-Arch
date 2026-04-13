#!/usr/bin/env bash

set -euo pipefail

FILES=("$HOME/.favourites" "$HOME/.local/.favourites")

print_all() {
    for f in "${FILES[@]}"; do
        [[ -f "$f" ]] && cat "$f"
    done
}

search_fuzzy() {
    local query="$1"

    for f in "${FILES[@]}"; do
        [[ -f "$f" ]] || continue

        awk -v q="$query" '
        BEGIN {
            IGNORECASE = 1
            RS=""
            FS="\n"
        }

        {
            block = ""
            for (i = 1; i <= NF; i++) {
                block = block $i "\n"
            }

            if (block ~ q) {
                print block
            }
        }
        ' "$f" && return
    done
}

main() {
    if [[ $# -eq 0 ]]; then
        print_all
    else
        search_fuzzy "$1"
    fi
}

main "$@"
