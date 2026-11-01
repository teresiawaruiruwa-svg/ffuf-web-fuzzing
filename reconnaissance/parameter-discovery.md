# GET and POST parameter discovery

## GET parameter discovery

The screenshots show FFUF using a parameter-name wordlist against a course resource:

```bash
ffuf -w /path/to/burp-parameter-names.txt \
  -u 'http://<HOST>:<PORT>/courses/<RESOURCE>?FUZZ=key' \
  -fs <BASELINE_SIZE>
```

The captured output included `user` and `username` as candidates. A later manual request used `username` in a POST body.

## POST parameter discovery

The screenshots show a POST-based FFUF configuration with:
- Method: `POST`
- Content type: `application/x-www-form-urlencoded`
- Data template: `FUZZ=key`
- A Burp parameter-name wordlist

General pattern:

```bash
ffuf -w /path/to/burp-parameter-names.txt \
  -X POST \
  -d 'FUZZ=<LAB_TEST_VALUE>' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'http://<HOST>:<PORT>/<PATH>'
```

## Manual follow-up

A screenshot shows a manual POST request using a `username` field:

```bash
curl -s -X POST 'http://<HOST>:<PORT>/<PATH>' \
  -d 'username=<LAB_TEST_VALUE>' \
  -H 'Content-Type: application/x-www-form-urlencoded'
```

## Interpretation

A candidate parameter should be confirmed by comparing the application's response when the parameter is present, absent, or supplied with different benign test values. A response difference is an observation; it is not automatically a security vulnerability.
