# Web extension discovery

## Objective

Test likely file extensions against a known or suspected resource name.

## Command pattern

```bash
ffuf -w /path/to/extension-wordlist.txt \
  -u 'http://<HOST>:<PORT>/<RESOURCE>FUZZ'
```

Adjust the placement of `FUZZ` to match the resource pattern being tested.

## Evidence from the screenshots

The extension list included `.bat`, `.js`, `.com`, `.exe`, `.phtml`, `.shtml`, `.mdb`, `.reg`, `.nsf`, `.php5`, `.rb`, `.php3`, `.jsp`, `.aspx`, `.php4`, `.php`, `.php7`, `.phar`, `.asp`, `.pcap`, `.sh`, `.pl`, `.pht`, `.php6`, `.php2`, `.inc`, and `.swf`.

The output showed different response behavior for some extensions. For example, `.php` and `.php7` returned `200` in one captured scan while many other candidates returned `404`. Another result showed `.phps` returning `403`.

## Interpretation

These results identify candidates for validation, not proof that each extension maps to an executable or accessible application. Compare response bodies and headers and verify the actual resource behavior.
