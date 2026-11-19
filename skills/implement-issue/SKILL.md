---
name: implement-issue
description: Take a GitHub issue from ticket to pull request. Reads the issue and the code, asks questions, weighs more than one plan, implements, steps back, fixes findings, and opens the PR. Use when the user says "implement issue N", "work issue N", "do #N", or runs /implement-issue.
---

# Implement issue

Input: an issue number. Output: a pull request that closes it.

The user has authorised going from plan to implementation without a plan-approval pause,
once you have weighed more than one plan. This overrides any rule that asks for plan
approval before editing. The repo's own rules (`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`)
still govern branches, commits, versioning, writing and the PR body; follow them and don't
restate them.

## Steps

1. **Read.** `gh issue view N --comments`, the code the issue touches, and the repo rules.
   Read other repos or PRs only if the issue names them, plus the 2-3 closest merged PRs.
   Skim; don't ingest.
2. **Ask.** Ask only what the issue and code can't answer; for a small, clear issue, skip
   this and note any interpretation you made in the PR. Interactive: ask, then wait.
   Non-interactive: post the questions on the issue and go on with stated assumptions.
3. **Research**, only when the approach has a real choice or the technology may have
   moved: run `research-practices`.
4. **Weigh.** For anything with a real design choice, run `weigh-plans` and take its pick;
   for an obvious change, just plan it. If the pick is too big for one
   reviewable PR, split it into ordered PRs and do the first.
5. **Build.** Branch from the up-to-date default branch, implement, and run the repo's
   checks and tests.
6. **Run it for real.** Tests passing is not enough; see the change work. Look for what the
   repo already offers (`scripts/`, the README, a Makefile or task runner, data pulls,
   fixtures, a dev server) and use it. If the issue gives concrete data, such as an id,
   account, date or example input, run that exact case before and after, and put the
   comparison in the PR's Validation section. If nothing in the repo can exercise the
   change, say so there rather than leaving it unstated. For CI, auth or infra changes,
   also review it as a security researcher would. Show any destructive command before
   running it.
7. **Step back.** Run `step-back`, then act on its groups:
   - Fix now: fix it.
   - Ask: take the recommended option and note it in the PR. Stop and ask the user only if
     the answer changes the issue's scope or the action is irreversible or outward-facing.
   - Fix later: one line in the PR. Don't open issues.
8. **Ship.** Commit, push, open the PR per the repo rules. The How section gives the
   chosen plan plus one line per rejected plan.
9. **After merge**, update or close the issue.
