---
title: Put it back
requires: [verify:notes-gone, verify:notes-back, quiz:gating]
---

# Put it back

Learners break things. A document can only say "if that happens, start
again". A workshop that took a checkpoint can put the files back.

Delete the notes. The command below does it; so does the file browser,
in which case click Check afterwards.

```{execute}
:id: delete-notes
:session: workshop
rm -rf notes
:windows:
Remove-Item -Recurse -Force notes
```

```{verify}
:id: notes-gone
:label: The notes are gone
:substrate: contents
:trigger: after:delete-notes
missing notes/today.md
```

Now restore the checkpoint the previous page took. Everything in the
working directory goes back to how it was at that moment, and so do
the variables.

```{restore}
:id: restore-notes
:name: notes-titled
```

```{verify}
:id: notes-back
:label: Both notes are back
:substrate: contents
:trigger: after:restore-notes
exists notes/today.md
exists notes/{{ project_name }}.md
```

Restart, in the workshop browser, goes further: it empties the working
directory and fills it again from the files the workshop ships, so a
learner can always get back to a clean start without help.

One question to finish.

```{quiz}
:id: gating
:title: What you saw
question: Under strict gating, when does Next become available?
options:
  - text: When every check, quiz and form the page requires is complete
    correct: true
  - text: After a fixed time on the page
    explanation: Time is never a requirement; only checks, quizzes and forms are.
  - text: Once the page has been scrolled to the end
    explanation: Reading is not doing, which is the point of this workshop.
explanation: The page's requires list names its checks, quizzes and forms. Strict gating holds Next until all are done; soft gating lists what is missing but lets you go on.
```
