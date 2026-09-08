# jupyterlab-workshop showcase

[![Launch on Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/GrahamDumpleton/jupyterlab-workshop-showcase/main?urlpath=lab)

Three short workshops that show what
[jupyterlab-workshop](https://github.com/GrahamDumpleton/jupyterlab-workshop)
does, and why you would use it rather than a notebook with the
instructions written in it. The repository is also a working collection
of workshops: its layout, index, Binder files and CI workflow are the
pattern to copy for a collection of your own.

jupyterlab-workshop is a JupyterLab extension that shows workshop
instructions in a side panel, with clickable actions that drive the
live session: terminals, files, the editor, notebooks, kernels and the
window layout. Workshops can check what the learner has done, hold a
page until it is done, ask questions, and put files back when they go
wrong. A workshop is a directory of a `workshop.yaml` manifest and
Markdown pages, so it lives in git and runs wherever JupyterLab runs.
The [documentation](https://jupyterlab-workshop.readthedocs.io/) covers
the whole format.

## The workshops

Take them in order; each is ten to twenty minutes.

- **Why a workshop?** does one small task from a notebook of
  instructions, then does it again as a workshop, so the difference is
  felt rather than argued: actions that open the terminal and run the
  commands, a check that turns green by itself, a panel that knows who
  you are and how far you have got, and a window that arranges itself
  for the lesson. It ends by opening its own source.

- **Guided, not just documented** is about instructions that check
  your work. Three tasks done by hand, each noticed by a check, with
  strict gating that holds the next page until the check passes, a form
  whose answer flows into the text, the commands and the checks, a
  check written in Python, and a checkpoint that puts the files back
  after you delete them.

- **Write your own** scaffolds a workshop with the `jupyter workshop`
  command, adds a page with an action and a check, lints it, breaks it
  and fixes it, and writes a collection index for it, the same kind of
  index this repository has at its root.

## Launch on Binder

The badge above starts a JupyterLab on [mybinder.org](https://mybinder.org)
with the three workshops listed in the workshop browser, ready to open.
Nothing is downloaded and no trust dialog is shown, because the
`binder/postBuild` script installs a settings override that marks the
checkout's workshops as trusted and subscribes to the checkout's own
`collection.json`, which lists them in order. A link can open one
workshop directly by naming its directory in the checkout:

```
https://mybinder.org/v2/gh/GrahamDumpleton/jupyterlab-workshop-showcase/main?urlpath=lab%3Fworkshop%3Dworkshops%2Fwhy-a-workshop
```

The `urlpath` is `lab?workshop=workshops/why-a-workshop`, URL-encoded.
Binder sessions are temporary: anything you do in one is gone when it
ends.

## Run locally

Install JupyterLab and the extension into a virtual environment, start
JupyterLab from the checkout, and the workshops appear under Installed in
the workshop browser, because they sit in the `workshops` directory the
extension looks in by default:

```
git clone https://github.com/GrahamDumpleton/jupyterlab-workshop-showcase
cd jupyterlab-workshop-showcase
python3 -m venv .venv && source .venv/bin/activate
pip install -r binder/requirements.txt
jupyter lab
```

Open "Browse Workshops" from the launcher, or go straight to one with
`http://localhost:8888/lab?workshop=workshops/why-a-workshop`. Opening
`http://localhost:8888/lab?collection=collection.json` instead adds the
collection for the session, so the browser lists the workshops in the
collection's order under its title. Outside Binder the trust dialog
appears when a workshop opens; it lists what the workshop's pages are
allowed to do.

## Subscribe from your own JupyterLab

With the extension installed anywhere, subscribe to this collection and
the workshops are offered under Available in the workshop browser, with
Install fetching each from this repository. In the browser, choose
"Collections…" and enter the raw URL of the index:

```
https://raw.githubusercontent.com/GrahamDumpleton/jupyterlab-workshop-showcase/main/collection.json
```

A launch link does the same for one session, landing in the browser
with the collection on offer:

```
http://localhost:8888/lab?collection=https://raw.githubusercontent.com/GrahamDumpleton/jupyterlab-workshop-showcase/main/collection.json
```

## What is in the repository

```
collection.json          the index the workshop browser reads
icon.svg                 the collection's icon, embedded in the index
workshops/
  why-a-workshop/        a workshop: workshop.yaml and pages/*.md
  guided-not-documented/
  write-your-own/
binder/
  requirements.txt       JupyterLab and the extension, pinned to a release
  runtime.txt            the Python version for the Binder image
  postBuild              writes the settings override described above
.github/workflows/
  test.yml               lints and self-tests every workshop on every push
```

Each workshop is self-contained and can be copied out on its own. The
index lists them in the order they are shown, each entry pointing at
its directory in this repository at the `main` branch, and was written
by `jupyter workshop index`. To refresh it after editing a manifest, run
from the checkout:

```
jupyter workshop index workshops
```

It updates the entries in place and keeps their order and the
collection's own title, description and icon. The icon is embedded as a
`data:` URI rather than referenced by path, because GitHub serves raw
SVG files as plain text, which browsers will not draw.

## Checking the workshops

`jupyter workshop lint` reads a workshop's manifest and pages and reports
problems; it needs Node.js on the path. `jupyter workshop test` starts a
JupyterLab of its own, opens the workshop trusted, runs every action,
check, quiz and form in order, and reports PASS or FAIL for each. The
self-test needs the `test` extra and a browser for Playwright:

```
pip install "jupyterlab-workshop[test]"
playwright install chromium
jupyter workshop lint collection.json
jupyter workshop lint workshops/why-a-workshop
jupyter workshop test workshops/why-a-workshop
```

The workflow in `.github/workflows/test.yml` runs both for every
workshop on Linux and Windows, installing the release named in
`binder/requirements.txt`, so CI tests exactly what Binder serves.

## Updating the release

The extension version is pinned once, in `binder/requirements.txt`.
Bump it there when a new release is out; Binder builds a fresh image
for the new commit, and CI tests the workshops against the new release.
