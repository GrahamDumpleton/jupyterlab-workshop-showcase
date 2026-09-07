---
title: Your own words
requires: [form:project, verify:project-note]
---

# Your own words

Instructions that say "your project" leave the learner translating. A
workshop can ask once and use the answer everywhere: in the text, in
commands, and in checks.

```{form}
:id: project
:title: Your project
- { name: project_name, type: text, label: Project name, required: true, pattern: "^[a-z][a-z0-9-]*$", description: "Lower case letters, digits and hyphens" }
```

Now the task, and it is about {var}`project_name`: add a second note
in `notes`, named {var}`project_name`.md, with anything at all in it.
The name in this sentence, in the check below and in the button changed
when you pressed Submit.

```{file-write}
:id: write-project-note
:path: notes/{{ project_name }}.md
Notes about {{ project_name }}.
```

```{verify}
:id: project-note
:label: notes/{{ project_name }}.md exists
:substrate: contents
:trigger: after:write-project-note; interval 3s
exists notes/{{ project_name }}.md
```

A form is one way to collect values. A launch link can carry them, so
a link handed to a class sets the class's own names, and a workshop can
declare defaults, which is where `my-project` came from.
