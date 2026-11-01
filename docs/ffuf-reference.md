# FFUF command reference used in this project

This is a concise reference to options visible in, or directly relevant to, the supplied lab screenshots.

| Option | Meaning |
|---|---|
| `-w` | Wordlist file |
| `-u` | Target URL |
| `-H` | Add an HTTP request header |
| `-X` | Set HTTP method |
| `-d` | Send request data/body |
| `-fs` | Filter responses by size |
| `-fc` | Filter responses by status code |
| `-fw` | Filter responses by word count |
| `-fl` | Filter responses by line count |
| `-mc` | Match responses by status code |
| `-ic` | Ignore wordlist comments |
| `-of` | Select output format |
| `-o` | Write output to a file |

## Practical notes

- `FUZZ` marks the position where each wordlist entry is inserted.
- Choose a wordlist that matches the discovery task.
- Measure the baseline response before applying a size filter.
- Re-check filters after target resets because response sizes may change.
- Preserve the exact command and output format used during a successful run.
- Avoid excessive concurrency on systems outside a controlled lab. Follow the lab's rules and service limits.
