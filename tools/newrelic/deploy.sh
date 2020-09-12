#!/bin/zsh

set -e

TMP1=/tmp/lhs_$$
git log HEAD \
  -n 1 \
  --pretty=format:'{"revision": "%h",%n  "changelog": "%s",%n  "description": "%b"}'  \
> $TMP1

cat <<EOF | jq -s ".[0] * .[1]" $TMP1 - \
  | jq '{"deployment": .}' \
  | curl -i -X POST "https://api.newrelic.com/v2/applications/664414600/deployments.json" \
      -H "X-API-Key: NRRA-f38a89088f5297373ae764475d17282cfda3b89aa5" \
      -H "Content-Type: application/json" -d @-
{
  "user": "$(git config user.name)<$(git config user.email)> "
}
EOF
