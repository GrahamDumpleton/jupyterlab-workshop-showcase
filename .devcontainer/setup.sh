#!/bin/bash
# Run once when the codespace is created. Installs JupyterLab and the
# extension from the same pinned requirements the Binder image uses, then
# writes the JupyterLab overrides the Binder postBuild writes, except that
# the welcome message is the Codespaces one: a codespace belongs to the
# person who created it and persists, where a Binder session is anonymous
# and temporary.
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
    "trustPolicy": { "forcedLevel": "trusted" },
    "disabledFeatures": [
      "open-directory",
      "open-url",
      "collections",
      "catalogs",
      "remove",
      "author"
    ]
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
