# DNS subdomain discovery

## Objective

Enumerate candidate DNS subdomain names using a DNS-oriented wordlist.

## Distinction from virtual-host fuzzing

DNS subdomain discovery tests name resolution. HTTP virtual-host discovery sends different `Host` header values to a web server. A name may be relevant to one technique without being confirmed by the other.

## Evidence from the screenshots

The supplied screenshots show a DNS-style enumeration exercise against `inlanefreight.com`. Names displayed in the output include:

- `blog`
- `support`
- `www`
- `ns3`
- `my`
- `customer`

These are recorded as observed scan output from that exercise. They should not be merged with the `academy.htb` virtual-host findings.

## Reproduction

Use the DNS enumeration method and wordlist specified by the lab. Record the resolver, target domain, wordlist, and results. Only test domains within the scope of the authorized exercise.
