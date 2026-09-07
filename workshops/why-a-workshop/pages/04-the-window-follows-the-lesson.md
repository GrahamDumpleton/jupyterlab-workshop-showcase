---
title: The window follows the lesson
---

# The window follows the lesson

A page about a file wants the file in view, and a page about the
terminal wants the terminal. A notebook of instructions leaves
arranging the window to the learner, who has enough to do. A workshop
can arrange it.

This layout puts the file above the terminal, with the panel on the
right. Layouts are declared in the manifest, one line per region, and a
page applies one with a single action.

```{layout}
:name: workbench
```

It can walk you around the window. Each stop has a button to move on.

```{tour}
- selector: "#jupyterlab-workshop-panel"
  text: The instructions, with the progress bar and page list in the header.
- selector: "#jp-main-dock-panel"
  text: The main area, arranged by the layout you just applied.
- selector: ".jp-Terminal"
  text: The terminal the commands ran in. It stays open from page to page.
```

It can point at one thing without a tour, or say something in passing.

```{highlight}
:selector: .jp-FileEditor
:duration: 4s
The file the command wrote.
```

```{toast}
:type: success
Nothing to copy, nothing to find. The workshop did it.
```
