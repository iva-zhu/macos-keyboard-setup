#!/usr/bin/env bash
# Open the browser chosen by the user.
#
# Bundle id comes from ~/.config/aerospace/browser.conf (first non-empty line,
# written by install.sh). Missing or empty file -> BROWSER_DEFAULT below.
# Override for one run:  BROWSER_BUNDLE_ID=com.google.Chrome open-browser.sh
set -euo pipefail

BROWSER_DEFAULT="com.apple.Safari"
conf="$HOME/.config/aerospace/browser.conf"

bid="${BROWSER_BUNDLE_ID:-}"
if [[ -z $bid && -r $conf ]]; then
	bid="$(head -n1 "$conf" | tr -d '[:space:]')"
fi
[[ -n $bid ]] || bid="$BROWSER_DEFAULT"

exec open -b "$bid"
