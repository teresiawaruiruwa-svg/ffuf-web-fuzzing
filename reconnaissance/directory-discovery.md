# Directory and file discovery

## Objective
Identify discoverable web paths and files by placing FUZZ in the URL path.

## Command pattern
    ffuf -w /path/to/directory-wordlist.txt -u http://<TARGET>:<PORT>/FUZZ

Use -ic when the wordlist contains comment lines that should be ignored. Screenshot 01 records a comment line being processed because this option was not used in that run.

## Observations from the screenshots
- The initial directory scan shows /forum returning HTTP 301.
- A follow-up browser/request capture shows content from a page under /blog.
- A recursive scan identifies /forum/flag.php (HTTP 200, 21 bytes) and /blog/home.php (HTTP 200).
- Manual validation is shown for the discovered paths. Any flag value is redacted in the published evidence.

## Interpretation
A discovered path is a lead for further inspection. Validate it with a direct request, inspect the body and headers, and record whether it is a directory, application page, redirect, or access-controlled resource. A 200 response does not by itself establish that a resource is useful or vulnerable.

## Evidence
The screenshot index in evidence/screenshots/README.md maps captures 01–03 to this workflow.