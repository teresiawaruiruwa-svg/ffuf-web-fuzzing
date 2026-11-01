# GET and POST parameter discovery

## GET parameter discovery
The screenshot shows FFUF using a parameter-name wordlist against a course resource:

    ffuf -w /path/to/burp-parameter-names.txt -u 'http://<HOST>:<PORT>/courses/<RESOURCE>?FUZZ=key' -ic -fs 774

The captured output contains one response-size outlier (780 bytes), but the parameter name is obscured by a window overlay. The exact GET parameter name is therefore not confirmed by the published screenshot. Do not infer that it was user or username.

## POST parameter discovery
The POST fuzzing screenshot clearly shows a parameter-name scan using POST, body template FUZZ=key, application/x-www-form-urlencoded, and response-size filter -fs 774.

Visible results include user (780 bytes) and username (781 bytes).

General pattern:

    ffuf -w /path/to/burp-parameter-names.txt -X POST -d 'FUZZ=<LAB_TEST_VALUE>' -H 'Content-Type: application/x-www-form-urlencoded' -u 'http://<HOST>:<PORT>/<PATH>'

## POST value fuzzing
A subsequent screenshot shows a value wordlist being tested in the username field. JSON output was processed to isolate a response-length difference, identifying a candidate value. The exact value is retained only as lab evidence and should not be reused against other systems.

## Manual follow-up
A screenshot shows a manual POST request using the discovered username value. The application returned the lab objective response. The flag is redacted in the published screenshot.

    curl -s -X POST 'http://<HOST>:<PORT>/<PATH>' -d 'username=<LAB_TEST_VALUE>' -H 'Content-Type: application/x-www-form-urlencoded'

## Interpretation
A candidate parameter should be confirmed by comparing application responses when the parameter is present, absent, or supplied with different benign test values. A response difference is an observation; it is not automatically proof of a security vulnerability.