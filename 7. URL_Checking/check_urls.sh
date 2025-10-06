#!/bin/bash

URL_FILE="urls.txt"

if [ ! -f "$URL_FILE" ]; then
    echo "Error: URL file '$URL_FILE' not found!"
    exit 1
fi

echo "Checking URLs from $URL_FILE..."
echo "---------------------------------------"

while IFS= read -r url; do
    if [[ -z "$url" || "$url" =~ ^# ]]; then
        continue
    fi

    STATUS=$(curl -o /dev/null -s -w "%{http_code}" "$url")

    if [ "$STATUS" -eq 200 ]; then
        echo "✅ Accessible: $url (Status: $STATUS)"
    else
        echo "❌ Not Accessible: $url (Status: $STATUS)"
    fi
done < "$URL_FILE"

echo "---------------------------------------"
echo "URL check completed."
