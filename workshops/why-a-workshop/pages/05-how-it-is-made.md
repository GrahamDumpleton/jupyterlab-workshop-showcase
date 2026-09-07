---
title: How it is made
---

# How it is made

What did all that take to write? A manifest and five Markdown pages,
and no code. Open the page you were on two steps ago and find the
button that ran the commands: it is a fenced block named `execute` with
the commands as its body, and the check under it is a block named
`verify` with one line saying what to look for.

```{file-open}
:path: pages/02-the-workshop-way.md
```

The manifest declares the title, the pages in order, the variables, the
layout you applied, and the capabilities: what the pages are allowed to
do, which is what the trust dialog shows when a workshop opens. Nothing
a page does goes beyond that list.

```{file-open}
:path: workshop.yaml
```

The format is plain text, so workshops live in git, are reviewed as
diffs, and are linted and self-tested before anyone sees them. This
workshop is one of three in a repository that is also a collection,
with an index the workshop browser reads, and the repository is the
pattern to copy for a collection of your own.

Press Finish for what to do next.
