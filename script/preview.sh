#!/usr/bin/env bash
# Builds and serves the site locally, the same way .github/workflows/pages.yml does:
# copies docs/ from the source repo next to _config.yml, then runs Jekyll on the result.
# Usage: ./script/preview.sh [path to the source repo]
set -e
cd "$(dirname "$0")/.."

SRC="${1:-../pdf-accessibility-remediation}"
OUT=/tmp/pages-preview

if [ ! -d "$SRC/docs" ]; then
  echo "No docs/ folder in $SRC. Clone the source repo there or pass its path." >&2
  exit 1
fi

rm -rf "$OUT" && mkdir "$OUT"
cp -R _config.yml _sass "$OUT/"
cp -R "$SRC/docs/." "$OUT/"

bundle exec jekyll serve --source "$OUT" --destination "$OUT/_site" --livereload
