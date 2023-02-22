#!/usr/bin/env bash

set -e

# Optimize JPG
while IFS= read -r -d '' file_jpg; do
    if [ -f "${file_jpg}.optimized" ]; then
        continue
    fi
    echo >&2 "[LOG] Optimizing image: ${file_jpg}"
    touch "${file_jpg}.optimized"
    jpegoptim -s "${file_jpg}"
done < <(find data -type f \( -name "*.jpg" -or -name "*.jpeg" \) -print0)

# Optimize PNG
while IFS= read -r -d '' file_png; do
    if [ -f "${file_png}.optimized" ]; then
        continue
    fi
    echo >&2 "[LOG] Optimizing image: ${file_png}"
    optipng -strip=all "${file_png}"
    touch "${file_png}.optimized"
done < <(find data -type f -name "*.png" -print0)

# Optimize GIF
while IFS= read -r -d '' file_gif; do
    if [ -f "${file_gif}.optimized" ]; then
        continue
    fi
    echo >&2 "[LOG] Optimizing gif: ${file_gif}"
    gifsicle -i "${file_gif}"  -o "${file_gif}" -O3 --colors 256 --resize-height 256
    touch "${file_gif}.optimized"
done < <(find data -type f -name "*.gif" -print0)
