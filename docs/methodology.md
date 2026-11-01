# Methodology

## 1. Scope
This document records the web fuzzing workflow demonstrated in screenshots from the HTB Academy module Attacking Web Applications with Ffuf.

The screenshots include several target addresses, ports, and hostnames. The user confirmed that these were captured during the same module and that target IPs changed after occasional lab resets. The report treats the different addresses as session-specific target instances.

## 2. Preparation
1. Confirm the lab target is active.
2. Record the current IP address, port, and hostname in private notes.
3. Confirm the correct wordlist exists locally.
4. Identify the request method and insertion point (FUZZ).
5. Measure a baseline where response filtering may be needed.
6. Keep the test within the authorized lab scope.

## 3. Directory and file discovery
Directory discovery places FUZZ in the URL path. Screenshot 01 shows /forum returning 301 and a wordlist comment line being processed because -ic was not used. Screenshots 02 and 03 show follow-up validation under /blog and a recursive scan identifying /forum/flag.php and /blog/home.php. Flag values are redacted in the FFUF evidence.

## 4. HTTP virtual-host discovery
Virtual-host fuzzing places FUZZ in the HTTP Host header. The screenshots show two sessions: an earlier scan used -fs 986 and identified test and admin; a later session measured a nonexistent-host baseline of 985 bytes and used -fs 985, identifying archive, test, and faculty.

These are separate observed session values, not contradictory constants. Re-measure the baseline after a target reset or when the host, port, or application changes.

## 5. DNS subdomain discovery
DNS enumeration tests whether names resolve in DNS. HTTP virtual-host enumeration tests how an HTTP server responds to different Host header values. The screenshots show a DNS-style scan for inlanefreight.com, including blog, support, www, ns3, my, and customer. Do not merge these with academy.htb virtual-host findings.

## 6. Extension discovery
The screenshots show tests including .php, .php7, .phps, .aspx, and .jsp. .php and .php7 returned 200 in the captured scan; .phps returned 403; many other candidates returned 404. A later recursive search isolates courses/linux-security.php7, and a manual request returns an access-denied message. A 200 response with an empty body is not proof of a useful file; validate candidates.

## 7. GET parameter discovery
The GET parameter screenshot shows a query-string insertion point and a 774-byte response-size filter. One 780-byte outlier is visible, but the parameter name is obscured by a window overlay. The exact GET parameter name is not confirmed by the published capture.

## 8. POST parameter discovery and value testing
The POST parameter screenshot clearly shows POST fuzzing with FUZZ=key, application/x-www-form-urlencoded, and -fs 774. It identifies user (780 bytes) and username (781 bytes). A later value-fuzzing screenshot shows JSON output processing to identify a candidate value. The subsequent manual POST request uses username with that candidate value and returns the lab objective response; the flag is redacted.

## 9. Response analysis
The screenshots include status codes 200, 301, 302, 403, and 404, plus response size, word count, line count, and duration. These are clues, not conclusions. Inspect redirects, compare against a baseline, and validate interesting responses manually.

## 10. Evidence and reproducibility
For each scan, retain session context, current lab target identifier in private notes, command, wordlist, filters, output, follow-up validation, and a short explanation. Historical IPs and ports are not permanent configuration. The screenshot index maps captures to the relevant sections and records evidence limitations.