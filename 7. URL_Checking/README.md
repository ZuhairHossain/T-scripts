# URL Accessibility Checker

This script checks if a list of URLs (from a file) are accessible by verifying their HTTP status code using `curl`.

## Features
- Reads URLs from a file (`urls.txt` by default).
- Skips empty lines and comments.
- Reports whether each URL is accessible (HTTP 200).

## Usage
1. Make the script executable:
   ```bash
   chmod +x check_urls.sh
   ```

2. Prepare a `urls.txt` file with one URL per line.

3. Run the script:
   ```bash
   ./check_urls.sh
   ```

## Example `urls.txt`
```
https://www.google.com
https://github.com
https://nonexistent.example.com
```

## Example Output
```
✅ Accessible: https://www.google.com (Status: 200)
❌ Not Accessible: https://nonexistent.example.com (Status: 000)
```
