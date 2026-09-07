---
title: A check
requires: [verify:first-note]
---

# A check

A document can tell you what to do. A guide notices whether you did it.
The block at the bottom of this page is a check. Click its Check button
now, before doing anything, and read what it says.

Then do the task, in whatever way you like: the terminal below, New
Folder and New File in the file browser, or the editor. Make a
directory called `notes` in the workshop directory, and inside it a
file called `today.md` that mentions the word "workshop".

The workshop directory is the one holding this workshop's
`workshop.yaml`. The terminal starts in it; this prints where that is.

```{execute}
:session: workshop
pwd
:windows:
Get-Location
```

Prefer to watch first? This button does the task. Delete the file
afterwards and do it by hand, and the check follows along.

```{file-write}
:id: write-today
:path: notes/today.md
Started the workshop today.
```

The check runs every few seconds while this page is showing, and
whenever `today.md` is saved from the editor, so it turns green on its
own a moment after you finish. This workshop uses strict gating: Next
stays disabled until it does, and the footer says what is still
missing.

```{verify}
:id: first-note
:label: notes/today.md exists and mentions the workshop
:substrate: contents
:trigger: after:write-today; interval 3s; file-saved notes/today.md
exists notes/today.md
contains notes/today.md workshop
```
