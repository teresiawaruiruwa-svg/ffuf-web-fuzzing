# Methodology

## 1. Scope

This document records the web fuzzing workflow demonstrated in the supplied screenshots from the HTB Academy module **Attacking Web Applications with Ffuf**.

The screenshots include several target addresses, ports, and hostnames. The user confirmed that these were captured during the same module and that target IPs changed after occasional lab resets. The report therefore treats the different addresses as session-specific target instances.

## 2. Preparation

Before each scan:

1. Confirm the lab target is active.
2. Record the current IP address, port, and relevant hostname.
3. Confirm the correct wordlist exists locally.
4. Identify the request method and insertion point (`FUZZ`).
5. Make a baseline request where response filtering may be needed.
6. Keep the test within the authorized lab scope.

## 3. Directory and file discovery

Directory discovery places the `FUZZ` keyword in the URL path. FFUF substitutes each wordlist entry and records the server response.

Example pattern:

```bash
ffuf -w /path/to/directory-wordlist.txt \
  -u http://<TARGET>:<PORT>/FUZZ
```

The screenshots show directory discovery against a lab web service using a SecLists/DirBuster directory wordlist. Results included paths such as `/forum`, `/blog`, and application files such as `home.php` in the observed lab instances.

A response code alone does not prove that a path is useful. Follow up by requesting the path and inspecting the response.

## 4. Virtual-host discovery

Virtual-host fuzzing places `FUZZ` in the HTTP `Host` header:

```bash
ffuf -w /path/to/subdomain-wordlist.txt \
  -u http://<BASE_HOST>:<PORT>/ \
  -H 'Host: FUZZ.<LAB_DOMAIN>' \
  -fs <BASELINE_SIZE>
```

The screenshots show this approach against `academy.htb` and a faculty host, with discovered names including `faculty`, `admin`, `archive`, and `test` in the relevant lab context.

### Baseline response filtering

A request using a deliberately nonexistent hostname was measured with `curl` and `wc -c`. One screenshot records a baseline response size of 985 bytes. The virtual-host scan then used `-fs 985` to suppress responses of that size.

This number is specific to that observed target instance. It must be measured again after a target reset or when the host, port, or application changes.

## 5. DNS subdomain discovery

DNS subdomain enumeration and HTTP virtual-host enumeration are related but distinct:

- DNS enumeration tests whether names resolve in DNS.
- Virtual-host enumeration tests how an HTTP server responds to different `Host` header values.

The screenshots show a DNS-style wordlist scan for names associated with `inlanefreight.com`, with results such as `blog`, `support`, and `www`. These results are recorded as an exercise in the module, not as evidence that those names belong to the other `academy.htb` target.

## 6. Extension discovery

Extension fuzzing appends candidate extensions to a known or suspected resource name. The screenshots show tests including `.php`, `.php7`, `.phps`, `.aspx`, `.jsp`, and other extensions.

Interpretation should consider:
- Status code
- Response size
- Redirect behavior
- Whether the response differs from a known missing-resource response
- Whether the resource can be retrieved in a browser or with a follow-up request

A `200` response with an empty body is not automatically proof of a useful application file. It requires validation.

## 7. GET parameter discovery

The screenshots show parameter-name fuzzing against a course endpoint using a query-string insertion point:

```bash
ffuf -w /path/to/burp-parameter-names.txt \
  -u 'http://<HOST>:<PORT>/courses/<RESOURCE>?FUZZ=key' \
  -fs <BASELINE_SIZE>
```

The observed output included parameter candidates such as `user` and `username`. The user then followed up with a request using the discovered parameter.

## 8. POST parameter testing

The screenshots show URL-encoded POST requests and a parameter-name fuzzing workflow against a course endpoint. A manual follow-up request used a `username` field.

General request pattern:

```bash
curl -s -X POST 'http://<HOST>:<PORT>/<PATH>' \
  -d 'username=<LAB_TEST_VALUE>' \
  -H 'Content-Type: application/x-www-form-urlencoded'
```

The response should be inspected for meaningful application behavior. Do not treat a changed response as proof of a vulnerability without understanding the application logic and confirming the result.

## 9. Response analysis

The screenshots include status codes such as `200`, `301`, `302`, `403`, and `404`, as well as response sizes, word counts, line counts, and request durations.

Use these fields as clues, not conclusions:

- `200`: request was handled successfully; the body may still be empty or generic.
- `301` / `302`: redirection occurred; inspect the `Location` header and decide whether following redirects is appropriate.
- `403`: the server understood the request but denied access.
- `404`: the requested resource was not found.
- Response size: useful for detecting outliers against a baseline, but not sufficient by itself.

## 10. Evidence and reproducibility

For each scan, retain:
- Date/session context
- Current lab target identifier (avoid publishing private access details)
- Command used
- Wordlist path and source
- Filters and matchers
- Relevant output
- Follow-up validation
- Short explanation of what was learned

Because target instances changed after resets, historical IPs and ports should not be used as permanent configuration.
