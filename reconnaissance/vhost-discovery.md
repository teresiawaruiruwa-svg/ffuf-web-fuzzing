# HTTP virtual-host discovery

## Objective

Identify hostnames handled by the same web server by fuzzing the HTTP `Host` header.

## Command pattern

```bash
ffuf -w /path/to/subdomain-wordlist.txt \
  -u http://<BASE_HOST>:<PORT>/ \
  -H 'Host: FUZZ.<LAB_DOMAIN>' \
  -fs <BASELINE_SIZE>
```

## Baseline measurement

The screenshots show a request using a nonexistent hostname and measuring the response body length:

```bash
curl -s -H 'Host: doesnotexist.<LAB_DOMAIN>' \
  http://<BASE_HOST>:<PORT>/ | wc -c
```

One observed target returned a 985-byte baseline. The corresponding scan filtered that size using `-fs 985`.

## Observed names

The screenshots show the following names in the `academy.htb` lab context:

- `faculty`
- `admin`
- `archive`
- `test`

The exact target IP and port varied between screenshots because the lab was reset. Use the current target values when reproducing the scan.

## Validation

Add the discovered hostname to the local hosts file only when required by the lab workflow and only using the current target IP. Then make a direct request and inspect the response. Do not publish a hosts file containing stale target mappings.
