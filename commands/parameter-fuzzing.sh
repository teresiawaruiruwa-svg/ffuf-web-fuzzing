#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 5 ]]; then
  echo "Usage: $0 <GET|POST> <url-with-FUZZ> <wordlist> <test-value> <output-file>"
  echo "GET example:  $0 GET 'http://127.0.0.1:8080/page?FUZZ=1' params.txt test get.json"
  echo "POST example: $0 POST 'http://127.0.0.1:8080/page' params.txt test post.json"
  exit 1
fi

METHOD="${1^^}"
URL="$2"
WORDLIST="$3"
TEST_VALUE="$4"
OUTPUT="$5"

if [[ "$METHOD" != "GET" && "$METHOD" != "POST" ]]; then
  echo "Method must be GET or POST." >&2
  exit 1
fi

if [[ ! -f "$WORDLIST" ]]; then
  echo "Wordlist not found: $WORDLIST" >&2
  exit 1
fi

if [[ "$METHOD" == "GET" ]]; then
  if [[ "$URL" != *FUZZ* ]]; then
    echo "For GET fuzzing, the URL must contain FUZZ in the parameter-name position." >&2
    exit 1
  fi
  ffuf -w "$WORDLIST" \
    -u "$URL" \
    -of json \
    -o "$OUTPUT"
else
  ffuf -w "$WORDLIST" \
    -X POST \
    -d "FUZZ=${TEST_VALUE}" \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -u "$URL" \
    -of json \
    -o "$OUTPUT"
fi
