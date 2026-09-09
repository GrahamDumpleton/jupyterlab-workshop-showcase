---
title: It knows where you are
requires: [form:who]
---

# It knows where you are

A notebook does not know who is reading it or how far they have got.
The panel does. The bar in its header is your progress, and the page
list behind the title marks the pages you have finished. The previous
page needed its check to pass before it counted as done, and the footer
said so.

It knows things about you, too. So far it calls you {var}`learner`,
which is a default from the manifest. Tell it your name.

```{form}
:id: who
:title: Who you are
- { name: learner, type: text, label: Your name, required: true }
```

```{when} learner != "friend"
Hello, {var}`learner`. This page re-rendered as soon as you pressed
Submit, and so did every other page that mentions you.
```

Values reach commands as environment variables, so a terminal step can
be about your things rather than everyone's.

```{execute}
:session: demo
echo "Hello, $LEARNER"
:windows:
echo "Hello, $env:LEARNER"
```

Progress and answers are kept in the workshop's own directory, under
`_workshop`, so closing the browser tab and coming back later resumes
where you left off. Everything you make lives in the working directory
beside it, `work`. Restart, in the workshop browser, forgets it all and
empties that directory, so the files are as they were when the workshop
was first opened.
