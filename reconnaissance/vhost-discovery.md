# HTTP virtual-host discovery

## Objective
Identify hostnames handled by the same web server by fuzzing the HTTP Host header.

## Command pattern
    ffuf -w /path/to/subdomain-wordlist.txt -u http://<BASE_HOST>:<PORT>/ -H 'Host: FUZZ.<LAB_DOMAIN>' -fs <BASELINE_SIZE>

## Baseline measurement and session differences
The screenshots show two different baseline sizes from separate lab sessions:
- An earlier virtual-host scan used -fs 986 and found test and admin.
- A later session measured a nonexistent-host response at 985 bytes using curl and wc -c, then used -fs 985.

These values are session-specific. Recalculate the baseline after every target reset and whenever the host, port, or application changes. Do not treat either value as a universal constant.

## Observed names
- test and admin in the earlier academy.htb scan.
- archive, test, and faculty in a later skills-assessment scan.

A subsequent filtered capture shows three results, but the names are obscured by a window thumbnail overlay. That capture should not be used to claim additional hostname values.

## Validation
Add the discovered hostname to the local hosts file only when required by the lab workflow and only using the current target IP. Then make a direct request and inspect the response. Do not publish a hosts file containing stale target mappings.