#!/bin/bash
# Run once when the codespace is created. Installs JupyterLab and the
# extension from the same pinned requirements the Binder image uses, then
# writes the JupyterLab overrides the Binder postBuild writes, with two
# differences, both because a codespace belongs to the person who created
# it, tied to their GitHub account, and persists, where a Binder session
# is an anonymous, temporary container. The welcome message is the
# Codespaces one. And workshops are not forced to trusted, so the learner
# is shown what a workshop asks to do and decides before it runs anything
# in their codespace. The analytics block is the same as Binder's but
# carries a token of its own, so the service tells the two apart and
# either can be revoked alone; it is as public as this file and only
# routes anonymous progress events to the showcase's service. The
# second block is JupyterLab's own: it turns off the question about
# fetching Jupyter news, which would otherwise come before the welcome
# message the first time the codespace's JupyterLab opens.
set -euo pipefail

cd "$(dirname "$0")/.."

python -m pip install --no-cache-dir -r binder/requirements.txt

# The overrides live in JupyterLab's application settings directory. Ask
# JupyterLab for it rather than assuming the Python prefix: it moves to
# the user's home for a user-level install, which pip falls back to when
# the prefix is not writable, and to /usr/local/share for some system
# installs. sudo covers a directory this user cannot write.
settings="$(python -c 'import os; from jupyterlab.commands import get_app_dir; print(os.path.join(get_app_dir(), "settings"))')"

overrides="$(mktemp)"

cat > "$overrides" <<'JSON'
{
  "@jupyterlab-workshop/labextension:panel": {
    "defaultWorkshop": "",
    "browseOnStart": true,
    "workshopsDirectory": "workshops",
    "collections": ["collection.json"],
    "welcome": ".devcontainer/welcome.md",
    "disabledFeatures": [
      "open-directory",
      "open-url",
      "collections",
      "catalogs",
      "remove",
      "author"
    ],
    "analytics": {
      "sink": "https://workshop-analytics.grumpys.work/events",
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI5Zjk1ZDIwMjVmYzE0MTQ0OWVjMjQ2ZTlhZDBhNjg1MCIsInN1YiI6InNob3djYXNlLWNvZGVzcGFjZXMiLCJzY29wZSI6WyJpbmdlc3QiXSwibGFiZWxzIjp7ImRlcGxveW1lbnQiOiJzaG93Y2FzZS1jb2Rlc3BhY2VzIn0sIm9yaWdpbnMiOltdLCJpYXQiOjE3ODk1MjgyMzQsIm5iZiI6MTc4OTUyODIzNCwiZXhwIjoxODIxMTM5MTk5fQ.CmkloE94utpWE0s41vQlWieNU8keiMxGnI_x8VIFuW4"
    }
  },
  "@jupyterlab/apputils-extension:notification": {
    "fetchNews": "false"
  }
}
JSON

if mkdir -p "$settings" 2>/dev/null && [ -w "$settings" ]; then
  install -m 644 "$overrides" "$settings/overrides.json"
else
  sudo mkdir -p "$settings"
  sudo install -m 644 "$overrides" "$settings/overrides.json"
fi

rm -f "$overrides"

echo "Wrote the JupyterLab overrides to $settings/overrides.json"
