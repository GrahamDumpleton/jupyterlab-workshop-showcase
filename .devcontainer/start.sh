#!/bin/bash
# Run each time the codespace starts. Starts JupyterLab in the background,
# detached so it outlives this script, with the checkout as its root so the
# workshops, collection.json and the welcome file resolve as they do on
# Binder. Output goes to /tmp/jupyterlab.log.
#
# Token authentication is off so the tab Codespaces opens on forwarding
# the port goes straight into JupyterLab. That relies on the forwarded
# port staying private, the default, which only the codespace's owner,
# signed in to GitHub, can reach. The welcome file tells the learner not
# to make it public. Remote access is allowed because requests arrive
# with the forwarded github.dev host name rather than localhost.
set -euo pipefail

cd "$(dirname "$0")/.."

if jupyter server list 2>/dev/null | grep -q ':8888/'; then
  exit 0
fi

setsid nohup jupyter lab \
  --no-browser \
  --ServerApp.ip=0.0.0.0 \
  --ServerApp.port=8888 \
  --ServerApp.root_dir="$PWD" \
  --IdentityProvider.token= \
  --ServerApp.allow_remote_access=True \
  --ServerApp.trust_xheaders=True \
  > /tmp/jupyterlab.log 2>&1 < /dev/null &
