---
title: The workshop way
requires: [verify:hello-file]
---

# The workshop way

Same task. This time each step is a button in this panel. Click them in
order and watch what happens outside it.

The first opens a terminal, already in the right directory, and runs
the commands in it. You do not have to find the terminal or type
anything.

```{execute}
:id: make-file
:session: demo
mkdir -p project
echo hello > project/hello.txt
:windows:
New-Item -ItemType Directory -Force project | Out-Null
"hello" | Set-Content project/hello.txt
```

The check below ran the moment the command was typed, without a click,
and turned green when the file appeared. It keeps watching: delete the
file and it goes red, make it again by hand and it recovers.

```{verify}
:id: hello-file
:label: project/hello.txt exists
:substrate: contents
:trigger: after:make-file; interval 5s
exists project/hello.txt
```

Open the file the command wrote, and show where it lives.

```{file-open}
:path: project/hello.txt
```

```{file-browser-reveal}
:path: project
```

Same task, three clicks, no hunting through tabs and no guessing. The
notebook could describe those steps. The workshop performed them, and
knows whether they worked.

If you did the task by hand on the previous page, the file was already
there and the commands did no harm. Actions are written to be safe to
repeat, because learners click twice.
