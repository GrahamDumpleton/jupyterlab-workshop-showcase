---
title: A check that runs code
requires: [verify:titled]
---

# A check that runs code

File predicates cover a lot, but some checks have to compute. A check
can be Python, run in a kernel the workshop keeps for itself, in the
workshop directory. A failing assertion's message is what the learner
sees, so the check can say exactly what is missing rather than just
"no".

The task: give every note in `notes` a title, a first line starting
with `# `. Open each file, add the line, save. The check runs whenever
either note is saved, and on a timer, and names the file that still
lacks a title.

Or let these two actions do it. Each inserts a line at the top of a
file and saves it.

```{editor-insert}
:id: title-today
:path: notes/today.md
:line: 1
:save: true
# Today
```

```{editor-insert}
:id: title-project
:path: notes/{{ project_name }}.md
:line: 1
:save: true
# {{ project_name }}
```

```{verify}
:id: titled
:label: Every note has a title line
:trigger: after:title-project; file-saved notes/today.md; file-saved notes/{{ project_name }}.md; interval 10s
:cascade: save-point
from pathlib import Path

notes = sorted(Path("notes").glob("*.md"))
assert notes, "There are no notes yet"

for note in notes:
    first = note.read_text().splitlines()[:1]
    assert first and first[0].startswith("# "), f"{note} has no title line"

print(f"{len(notes)} titled note(s): " + ", ".join(n.name for n in notes))
```

When the check passes it saves a checkpoint of the workshop directory,
files and variables together, so that the next page can break things
with a clear conscience.

```{checkpoint}
:id: save-point
:name: notes-titled
```
