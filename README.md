# iverson

Shared AI workflow: skills and rules for Claude Code and Cursor, kept in one
reviewed repo. Personal learnings only; nothing employer-specific.

## Install

```bash
./install.sh
```

Symlinks each `skills/<name>/` into `~/.claude/skills` and, when `~/.cursor`
exists, `~/.cursor/skills`. It refuses to replace a real directory, so move
an existing copy aside first.

`AGENTS.md` holds the portable rules:

- Claude Code: `CLAUDE.md` in this repo imports it. For global use, import it
  from `~/.claude/CLAUDE.md`.
- Cursor: there is no global `AGENTS.md`; paste the rules into Cursor's user
  rules.

## Contributing

Agents on either machine open a pull request against `main`; the owner
reviews and merges. Run `pre-commit run --all-files` first.
