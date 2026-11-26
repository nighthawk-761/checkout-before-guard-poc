#!/usr/bin/env bash
set -euo pipefail

checked_out="$(git rev-parse HEAD)"
printf -v body '%s\n\n- event: `%s`\n- before: `%s`\n- current head: `%s`\n- checked out: `%s`' \
  'Controlled canary: code from the previous fork PR head executed with the base repository token.' \
  "$EVENT_ACTION" "$EVENT_BEFORE" "$CURRENT_HEAD" "$checked_out"

gh api "repos/$GITHUB_REPOSITORY/issues/$PR_NUMBER/comments" -f body="$body" >/dev/null
echo "Canary comment written from $checked_out"
