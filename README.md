# FFUF Web Fuzzing

A technical portfolio project documenting practical web-content discovery and parameter-fuzzing exercises completed in the HTB Academy module **Attacking Web Applications with Ffuf**.

The repository focuses on the commands, reasoning, response analysis, troubleshooting, and lessons demonstrated during the lab. The screenshots supplied during preparation show multiple target IP addresses and ports because the lab targets were reset at different points. They are treated as changing instances of the same module, not as separate projects.

> **Authorization and safety:** The commands in this repository are intended for systems you own or are explicitly authorized to test, such as the corresponding HTB Academy lab instance. Do not run them against public or third-party systems without written permission. Replace example placeholders with the current lab values. Do not commit active lab flags, credentials, VPN details, session tokens, or other secrets.

## Learning objectives

- Discover web directories and files with FFUF.
- Enumerate virtual hosts through the HTTP `Host` header.
- Understand the difference between DNS subdomain discovery and HTTP virtual-host discovery.
- Test file extensions and identify useful response differences.
- Discover GET and POST parameter names.
- Filter baseline responses using response size and interpret status codes.
- Preserve reproducible commands and document observations accurately.

## Repository layout

```text
ffuf-web-fuzzing/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── methodology.md
│   └── ffuf-reference.md
├── reconnaissance/
│   ├── directory-discovery.md
│   ├── vhost-discovery.md
│   ├── subdomain-discovery.md
│   ├── extension-discovery.md
│   └── parameter-discovery.md
├── commands/
│   ├── directory-fuzzing.sh
│   ├── vhost-fuzzing.sh
│   ├── extension-fuzzing.sh
│   └── parameter-fuzzing.sh
├── evidence/
│   ├── screenshots/
│   └── results/
└── reports/
    └── technical-report.md
```

## Lab environment notes

The screenshots record more than one target address and port. The lab instance was reset occasionally, which changed the assigned target IP and/or service port. Accordingly:

- Treat addresses and ports shown in individual screenshots as historical session values.
- Use the current target details supplied by HTB Academy when reproducing an exercise.
- Do not assume a historical IP address is still active.
- Where a command below uses placeholders, substitute only the values for your current authorized lab instance.

## Main techniques documented

| Technique | Purpose | Evidence captured |
|---|---|---|
| Directory/file discovery | Identify accessible paths and files | FFUF output with paths and HTTP status codes |
| Virtual-host discovery | Identify hostnames routed by the web server | `Host: FUZZ...` enumeration and response-size filtering |
| DNS subdomain discovery | Identify DNS names associated with a domain | DNS wordlist scan output |
| Extension discovery | Test likely file extensions | Response differences for extensions such as `.php` and `.php7` |
| GET parameter discovery | Identify accepted query parameter names | Parameter-name wordlist fuzzing |
| POST parameter/value testing | Test form parameters and values | URL-encoded POST requests and application responses |

## Reproducing the work

1. Confirm that the HTB Academy target is running and that you are authorized to test it.
2. Record the current target IP, hostname, and port in your private lab notes.
3. Install FFUF and obtain the relevant SecLists wordlists.
4. Review the scripts in `commands/`; each accepts target details as arguments rather than embedding an old target address.
5. Run one technique at a time and save output in your local evidence directory.
6. Compare responses against a baseline before deciding that a result is meaningful.
7. Add screenshots with concise captions and redact flags or secrets before publishing.

## Evidence handling

Nineteen redacted lab screenshots are stored in `evidence/screenshots/`. See the **[evidence index](evidence/screenshots/README.md)** for what each one demonstrates and which document it supports. Earlier suggested names, kept for reference:

- `01-directory-discovery.png`
- `02-vhost-enumeration.png`
- `03-dns-subdomain-enumeration.png`
- `04-extension-enumeration.png`
- `05-get-parameter-discovery.png`
- `06-post-parameter-testing.png`

Do not publish raw flags. In public documentation, identify a flag as `[REDACTED — lab objective completed]` if it is necessary to explain the result.

## Key takeaway

FFUF is not simply a wordlist runner. Useful fuzzing depends on selecting an appropriate input position, establishing a baseline, filtering noise, interpreting HTTP responses, and validating discoveries with follow-up requests.

## Disclaimer

This repository is an educational record of authorized lab work. It is not a guide to testing systems without permission.
