#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <http-or-https-base-url> <wordlist> <output-file>"
  echo "Example: $0 http://127.0.0.1:8080 /path/to/wordlist.txt directory-results.json"
  exit 1
fi

BASE_URL="${1%/}"
WORDLIST="$2"
OUTPUT="$3"

if [[ ! -f "$WORDLIST" ]]; then
  echo "Wordlist not found: $WORDLIST" >&2
  exit 1
fi

ffuf -w "$WORDLIST" \
  -u "${BASE_URL}/FUZZ" \
  -of json \
  -o "$OUTPUT"
