# Technical Report: FFUF Web Fuzzing

## 1. Project overview

This project documents practical web fuzzing exercises completed in the HTB Academy module **Attacking Web Applications with Ffuf**. It records the techniques used to discover web paths, virtual hosts, subdomains, file extensions, and request parameters.

## 2. Environment and target-session note

The screenshots contain different target IP addresses and service ports. The user confirmed that all screenshots belong to the same Academy module and that the target instances were reset occasionally. IP and port changes are therefore treated as lab-session changes. Historical target addresses are not presented as stable infrastructure.

## 3. Techniques and observations

### 3.1 Directory and file discovery

FFUF was used with a directory wordlist and a URL path insertion point. The displayed output included `/forum`, `/blog`, `/home.php`, and `/forum/flag.php`. The screenshots show a mixture of response codes, making response validation important.

### 3.2 Virtual-host discovery

The HTTP `Host` header was fuzzed using a subdomain wordlist. A baseline request with a nonexistent hostname was measured using `curl` and `wc -c`. One captured baseline was 985 bytes, which was then filtered using `-fs 985`.

The screenshots show names including `faculty`, `admin`, `archive`, and `test` in the `academy.htb` lab context.

### 3.3 DNS subdomain discovery

A DNS-oriented wordlist exercise against `inlanefreight.com` displayed names including `blog`, `support`, `www`, `ns3`, `my`, and `customer`. This is documented separately from HTTP virtual-host enumeration because the techniques test different layers.

### 3.4 Extension discovery

The extension scan tested numerous candidates. The screenshots show differing responses for extensions including `.php`, `.php7`, and `.phps`. The result demonstrates why status code and response size should be compared with a baseline and then validated.

### 3.5 Parameter discovery

GET parameter fuzzing against a course endpoint displayed `user` and `username` as candidate names. The screenshots also show POST parameter fuzzing using `application/x-www-form-urlencoded`, followed by a manual request using a `username` field.

### 3.6 POST parameter/value testing

The supplied evidence includes manual POST requests to course and administrative endpoints. The responses demonstrated that the tested inputs reached application logic. This report does not infer an underlying vulnerability beyond what the screenshots demonstrate.

## 4. Response analysis

The screenshots show HTTP status codes including 200, 301, 302, 403, and 404. They also display response size, word count, line count, and duration. These are useful indicators for identifying outliers, but none should be treated as conclusive without follow-up validation.

## 5. Technical lessons

- The `FUZZ` keyword determines where wordlist entries are substituted.
- Wordlist selection should match the discovery objective.
- Baseline responses help reduce false positives.
- Response-size filters are target-specific and should be recalculated after resets.
- DNS subdomain discovery and HTTP virtual-host discovery are not interchangeable.
- GET and POST parameters must be tested in the correct request location and method.
- A promising response should be validated manually.
- Reproducible notes should include the command, wordlist, filters, and observed output.

## 6. Evidence limitations

This report is based on the screenshots supplied in the conversation. It does not include raw FFUF JSON output, complete HTTP response bodies, packet captures, or a full export of the Academy module. Where the screenshots do not show a complete command or response, the repository uses a clearly labelled generic command pattern rather than inventing missing values.

## 7. Conclusion

The exercise provided practical experience using FFUF for web content discovery and parameter enumeration. The main technical skill demonstrated is the ability to construct fuzzing requests, establish baselines, interpret response differences, and validate candidate discoveries in an authorized training environment.
