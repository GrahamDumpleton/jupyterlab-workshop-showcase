---
title: Share it
requires: [form:where, verify:indexed, quiz:final-quiz]
---

# Share it

Lint checks the files. The self-test checks that the workshop works:
`jupyter workshop test` starts a JupyterLab of its own, opens the
workshop trusted, runs every action, check, quiz and form in order, and
prints PASS or FAIL for each. It is what a workshop repository's CI
runs, and this collection's does.

```{hint}
:title: Running the self-test
It needs the `test` extra, which installs Playwright, and a browser for
it: `pip install "jupyterlab-workshop[test]"` and then
`playwright install chromium`. Run
`jupyter workshop test {{ workshop_dir }}` from a terminal outside
JupyterLab, since it starts a second one.
```

A workshop reaches learners through a collection: a `collection.json`
saying where each workshop can be fetched from, which they subscribe to
in the workshop browser. For workshops kept in a git repository,
`jupyter workshop index` writes that index from the manifests it finds,
pointing each entry at its directory in the repository, so nothing is
built or uploaded. Say where the new workshop will live; a stand-in
will do for now.

```{form}
:id: where
:title: Where it will live
- { name: repo_url, type: url, label: Repository URL, required: true, default: "https://github.com/you/my-workshop" }
```

Then write the index for it.

```{execute}
:id: index
:session: author
jupyter workshop index {{ workshop_dir }} --root {{ workshop_dir }} --out {{ workshop_dir }}/collection.json --repo {{ repo_url }} --ref main --title "My workshops"
```

```{verify}
:id: indexed
:label: The index lists the workshop
:substrate: contents
:trigger: after:index
exists {{ workshop_dir }}/collection.json
contains {{ workshop_dir }}/collection.json versions
```

```{file-open}
:path: {{ workshop_dir }}/collection.json
```

Push the workshop and its index to that repository, and the raw URL of
`collection.json` is what a learner subscribes to. This showcase is laid
out the same way: three workshops under `workshops/`, one index at the
root, a `binder/` directory so that one link starts it all on
mybinder.org, and a workflow that lints and self-tests every workshop on
every push. Copy it.

## Editing inside JupyterLab

Everything above was done from the terminal. The panel can do the same:
"Workshop: Author Mode" in the command palette adds a toolbar with
buttons to edit the page source, add and reorder pages, insert an action
from a form, capture what you just ran into the page, run the page's
actions and checks, show lint findings with one-click fixes, preview the
trust dialog and publish. Saving a page re-renders the panel. The Record
button turns a session into draft pages, one action per step.

AI agents can write workshops too: `jupyter workshop mcp` serves the
same tools over MCP, and the `workshop-author` skill that ships with the
extension explains the format to them.

```{quiz}
:id: final-quiz
:title: One last question
question: Which command runs every action of a workshop in a real JupyterLab?
options:
  - { text: jupyter workshop test, correct: true }
  - text: jupyter workshop lint
    explanation: Lint reads the files; it never runs anything.
  - text: jupyter workshop index
    explanation: Index writes the collection file from the manifests.
explanation: The self-test drives a headless JupyterLab through the workshop.
```
