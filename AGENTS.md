# Engineering rules

## Compatibility shims and boilerplate

Don't add forward-compatibility imports, polyfills, or version-guard
boilerplate out of habit, e.g. `from __future__ import annotations` in
Python. Check the project's pinned runtime first. If it already supports
what the shim enables, leave the shim out.

## Typed data over bare primitives

When a function returns more than one related piece of data, or a value
with real shape, return a named type (Pydantic model, dataclass, or
similar) rather than a bare `dict` or `tuple`. Keep it typed through the
call chain; drop to a primitive only where one is structurally required.

When retrofitting a bare return into a typed one, grep for every caller,
not just the ones in the current diff. Add a test for the specific branch
the change affects, not only a re-run of the happy path.

## Newspaper-style file layout

Put public functions at the top of a file and private helpers below. Don't
divide a file with comment banners; needing them means the file should be
split.

## Order side effects by dependency

When one write depends on another having succeeded, order the code so the
dependency is satisfied first. Validate inputs before any side effect that
is expensive or impossible to undo.

## Comment discipline

Don't add a comment unless it is strictly needed. Docstrings belong on
public functions only. When a comment is warranted, explain why, not what,
and keep it self-contained: no references to other code, files, or section
numbers in an external doc.

## Writing for readers

Applies to PR descriptions, commit bodies, issues, and chat summaries.

- Lead with the point: what changed or what to do, and why it matters.
- State facts once. No hedges, no open questions, no list of the change's
  own limitations.
- Don't narrate drafts or dead ends. Say what the final thing is.
- Numbers, not adjectives.
- If the reader must act after merge, say so in the first lines.
- Delete every sentence that wouldn't change what the reader does next.
