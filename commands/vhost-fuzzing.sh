#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 5 ]]; then
  echo "Usage: $0 <base-url> <wordlist> <host-suffix> <baseline-size> <output-file>"
  echo "Example: $0 http://127.0.0.1:8080 /path/to/subdomains.txt example.test 985 vhosts.json"
  exit 1
fi

BASE_URL="${1%/}"
WORDLIST="$2"
HOST_SUFFIX="$3"
BASELINE_SIZE="$4"
OUTPUT="$5"

if [[ ! -f "$WORDLIST" ]]; then
  echo "Wordlist not found: $WORDLIST" >&2
  exit 1
fi

if ! [[ "$BASELINE_SIZE" =~ ^[0-9]+$ ]]; then
  echo "Baseline size must be a non-negative integer." >&2
  exit 1
fi

echo "Use only against an authorized lab target."
echo "Baseline size supplied: ${BASELINE_SIZE} bytes"
ffuf -w "$WORDLIST" \
  -u "${BASE_URL}/" \
  -H "Host: FUZZ.${HOST_SUFFIX}" \
  -fs "$BASELINE_SIZE" \
  -of json \
  -o "$OUTPUT"
