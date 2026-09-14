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

# The overrides live in the application settings directory under the
# Python prefix. pip has just written to that prefix, so it is normally
# writable; sudo covers an image where it is not.
settings="$(python -c 'import sys; print(sys.prefix)')/share/jupyter/lab/settings"

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
