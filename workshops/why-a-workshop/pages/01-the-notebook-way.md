---
title: The notebook way
---

# The notebook way

Most teaching material for JupyterLab is a notebook: prose in Markdown
cells, code in code cells, and everything that happens somewhere else,
in a terminal or the file browser, described in words. This workshop
starts there, so that the difference is something you feel rather than
something you are told.

Click the block below to create the notebook and open it. It holds a
small task written the usual way. Blocks like that one are the
workshop's actions; this is the only one on this page, and the
notebook's own instructions take over from there.

```{notebook-create}
:path: notebook-way.ipynb
- markdown: |
    # A small task, the notebook way

    1. Open a terminal: File, New, Terminal.
    2. The terminal starts at the top of the file browser, not where
       this notebook is, so change into the directory holding this
       notebook first.
    3. Run `mkdir project` and then `echo hello > project/hello.txt`.
    4. Come back to this notebook and run the cell below to find out
       whether it worked.
- code: |
    from pathlib import Path

    print("done" if Path("project/hello.txt").exists() else "not yet")
```

Do the task. Find the terminal, work out the path, type the commands,
come back and run the cell.

Now count what the notebook left to you: opening the terminal, finding
the right directory, typing two commands without a slip, switching
tabs, keeping track of which step you were on, and running a cell to
learn whether it worked. None of that is the lesson. All of it is
friction, and a learner who mistypes the path gets "not yet" and
nothing more.

The next page does the same task as a workshop.
