#!/bin/sh
echo -ne '\033c\033]0;AsteroidsWorkshop\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/AsteroidsWorkshop.x86_64" "$@"
