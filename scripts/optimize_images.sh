#!/usr/bin/env bash

set -e

while IFS= read -r -d '' file_jpg; do
    echo >&2 "[LOG] Optimizing image: ${file_jpg}"
    jpegoptim -s "${file_jpg}"
done < <(find data -type f \( -name "*.jpg" -or -name "*.jpeg" \) -print0)

while IFS= read -r -d '' file_png; do
    echo >&2 "[LOG] Optimizing image: ${file_png}"
    optipng -strip=all "${file_png}"
done < <(find data -type f -name "*.png" -print0)
