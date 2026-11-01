# Technical Report: FFUF Web Fuzzing

## 1. Project overview
This project documents practical web fuzzing exercises completed in the HTB Academy module Attacking Web Applications with Ffuf. It records techniques used to discover web paths, virtual hosts, DNS subdomains, file extensions, and request parameters.

## 2. Environment and target-session note
The screenshots contain different target IP addresses and service ports. The user confirmed that all screenshots belong to the same Academy module and that target instances were reset occasionally. IP and port changes are treated as lab-session changes, not separate projects. Historical target addresses are not presented as stable infrastructure.

## 3. Techniques and observations
### 3.1 Directory and file discovery
The initial directory scan identified /forum with a 301 response. A wordlist comment line was also processed because -ic was not used. Follow-up captures show content under /blog and a recursive scan identifying /forum/flag.php and /blog/home.php. Manual validation is shown; flag values are redacted.

### 3.2 HTTP virtual-host discovery
The screenshots document two sessions. One used -fs 986 and identified test and admin. A later session measured a 985-byte response for a nonexistent hostname and used -fs 985; that scan identified archive, test, and faculty. These are session-specific baseline measurements and must be recalculated after target resets.

### 3.3 DNS subdomain discovery
A DNS-oriented wordlist exercise against inlanefreight.com displayed blog, support, www, ns3, my, and customer. This is separate from HTTP virtual-host enumeration because the techniques test different layers.

### 3.4 Extension discovery
The screenshots show .php and .php7 returning 200, .phps returning 403, and many other candidates returning 404. A later recursive result search isolated courses/linux-security.php7; a manual request returned an access-denied message. Status codes and response sizes were treated as leads requiring validation.

### 3.5 GET parameter discovery
The GET parameter screenshot shows an FFUF scan with a query-string insertion point and a 774-byte response-size filter. One 780-byte outlier is visible, but the parameter name is obscured by a window overlay. The exact GET parameter name is therefore not claimed.

### 3.6 POST parameter discovery and value testing
The POST parameter scan clearly identifies user and username as candidate names. A subsequent value-fuzzing capture shows JSON output being filtered to identify a candidate value. A manual POST request using the discovered username value returns the lab objective response; the flag is redacted.

## 4. Response analysis
The screenshots show HTTP status codes including 200, 301, 302, 403, and 404. They also display response size, word count, line count, and duration. These are useful indicators for identifying outliers, but none should be treated as conclusive without follow-up validation.

## 5. Technical lessons
- The FUZZ keyword determines where wordlist entries are substituted.
- Wordlist selection should match the discovery objective.
- Baseline responses help reduce false positives.
- Baseline response sizes are target- and session-specific.
- DNS subdomain discovery and HTTP virtual-host discovery are not interchangeable.
- GET and POST parameter discovery must be interpreted separately.
- A promising response should be validated manually.
- Reproducible notes should include the command, wordlist, filters, and observed output.

## 6. Evidence limitations
This report is based on the 19 screenshots indexed in evidence/screenshots/README.md. It does not include raw FFUF JSON output, complete HTTP response bodies, packet captures, or a full export of the Academy module. Some screenshot details are obscured by window overlays; the report avoids asserting values that cannot be read. Where screenshots do not show a complete command or response, the repository uses a clearly labelled generic command pattern rather than inventing missing values.

## 7. Conclusion
The exercise provided practical experience using FFUF for web content discovery and parameter enumeration. The main technical skills demonstrated are constructing fuzzing requests, establishing baselines, interpreting response differences, and validating candidate discoveries in an authorized training environment.