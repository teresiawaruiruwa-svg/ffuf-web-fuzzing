# Directory and file discovery

## Objective

Identify discoverable web paths and files by placing `FUZZ` in the URL path.

## Command pattern

```bash
ffuf -w /path/to/directory-wordlist.txt \
  -u http://<TARGET>:<PORT>/FUZZ
```

## Observations from the screenshots

The supplied terminal captures show directory discovery against a lab web server. Paths returned in the displayed results include:

- `/forum`
- `/blog`
- `/home.php`
- `/forum/flag.php`

Different requests produced different status codes. One screenshot shows a `200` response for a discovered forum flag endpoint; another shows a `200` response for `home.php`.

## Interpretation

A discovered path is a lead for further inspection. Validate it with a direct request, inspect the body and headers, and record whether it is a directory, application page, redirect, or access-controlled resource.

## Evidence to add

Place a sanitized screenshot in `../evidence/screenshots/` and reference it here with a short caption.
