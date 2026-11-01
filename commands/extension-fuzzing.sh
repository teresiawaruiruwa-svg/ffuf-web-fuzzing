#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <resource-url-with-FUZZ> <extension-wordlist> <output-file>"
  echo "Example: $0 http://127.0.0.1:8080/indexFUZZ /path/to/extensions.txt extensions.json"
  exit 1
fi

URL_PATTERN="$1"
WORDLIST="$2"
OUTPUT="$3"

if [[ "$URL_PATTERN" != *FUZZ* ]]; then
  echo "The URL pattern must contain the FUZZ keyword." >&2
  exit 1
fi

if [[ ! -f "$WORDLIST" ]]; then
  echo "Wordlist not found: $WORDLIST" >&2
  exit 1
fi

ffuf -w "$WORDLIST" \
  -u "$URL_PATTERN" \
  -of json \
  -o "$OUTPUT"
