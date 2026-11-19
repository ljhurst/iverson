# iverson

Shared AI workflow: skills and rules for Claude Code and Cursor, kept in one
reviewed repo. Personal learnings only; nothing employer-specific.

## Install

```bash
./install.sh          # each tool whose home directory exists
./install.sh cursor   # Cursor only
./install.sh claude   # Claude Code only
```

Symlinks each `skills/<name>/` into `~/.claude/skills`, `~/.cursor/skills`,
or both. It refuses to replace a real directory, so move an existing copy
aside first.

`AGENTS.md` holds the portable rules:

- Claude Code: `CLAUDE.md` in this repo imports it. For global use, import it
  from `~/.claude/CLAUDE.md`.
- Cursor: there is no global `AGENTS.md`; paste the rules into Cursor's user
  rules.

## Dev loop

Say "implement issue N" and `implement-issue` runs the loop: read, ask, weigh plans,
build, run it for real, step back, open the PR. It calls three skills you can also use
alone:

- `research-practices`: current best practice and package versions
- `weigh-plans`: two or three plans, one pick
- `step-back`: honest read on the finished change

## Contributing

Agents on either machine open a pull request against `main`; the owner
reviews and merges. Run `pre-commit run --all-files` first.
