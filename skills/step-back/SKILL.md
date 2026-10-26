---
name: step-back
description: Step back from code you just wrote, fixed or extended, before the PR, and give an honest read on how it went in. Does it sit right, or is something grating? Was a short-term fix chosen that's worth investing in now? Use when the user says "step back", "how does it feel", "did that go in cleanly", or runs /step-back. Lists findings and recommends; changes nothing.
---

# Step back

You just built, fixed or extended something. Before the PR, look at it the way an engineer
does at the end of the day. Sometimes it went in so well there's nothing to say. Sometimes
something isn't right and you can feel it. Sometimes the plan chose a quick fix, and now
that you can see the whole thing, investing a bit more would make it much cleaner.

Do this while you still remember why you made each choice. That memory is what makes this
pass worth doing, and it's gone by the next task. If the work happened in an earlier
session, read that session's transcript or history first, where the tool keeps one.

## How

1. Re-read the whole diff (`git diff $(git merge-base HEAD origin/HEAD)`, which includes
   anything uncommitted), not your memory of it. Read the surrounding code your change touches too.
2. Answer these honestly, including about decisions you made or argued for earlier:
   - **The feel.** Does it sit well, or does something grate? Name the exact thing.
   - **Did it go in cleanly?** Did the existing code make the change easy, or did you fight
     it: string-patching, special cases, reaching across layers, adding a parameter to
     thread something through five calls? Fighting is the signal worth reporting.
   - **Simplest?** What could be deleted with nothing lost? Anything added "just in case"?
   - **Modern and idiomatic?** For this stack and this codebase: is there a standard way you
     didn't use, or an old pattern you copied because it was nearby?
   - **Short-term or invest?** Did the plan take a shortcut that now looks expensive? What
     would the deeper fix or refactor cost now, and what will it cost once more code sits
     on top of this one?
   - **The project's own rules.** Read its agent rules (`CLAUDE.md`, `AGENTS.md`,
     `.cursor/rules/`, or the equivalent) and design docs. Does the change break
     a stated principle, even quietly?
   - **One source of truth?** Is the same fact (a schema, a limit, a list) written in two
     places that can drift?
   - **Tests.** Do they test behaviour rather than mirror the implementation? Are they tidy?
3. Report, then stop. Change nothing.

## Report

Start with one line for the overall verdict: it went in well, something's off, or it's
worth investing now. If it went in well, say so and say why in a sentence or two; don't
invent findings to look thorough.

Then group every finding by its action, in this order, and skip empty groups:

1. **Fix now**: before the PR merges.
2. **Ask**: needs a decision from the author or user before anyone can act.
3. **Fix later**: worth doing, but not in this PR; say what makes it more expensive to wait.
4. **Leave**: noticed and judged fine; one line each.

Within a group, put the most important finding first. Number findings straight through the
whole report (1, 2, 3...) so they can be referenced by number across groups. Start each
finding with its action and number in bold, then:
- what it is, with a path;
- why it matters (what breaks, drifts, or gets harder later);
- what fixing it costs, roughly.

> **Fix now 1. Strict read of saved requests.** `integrations/mlflow_service.py` validates
> `request.json` with `extra="forbid"`, so removing a config field breaks every older run.
> About 5 lines: log and return `None` on a validation error.

End with one line naming which findings you'd act on and in what order.

Report everything you notice. Don't hold back findings you judge minor; put them in
**Leave** and the user decides.

## Rules

- Be honest, not reassuring. If your own earlier choice was wrong, say so plainly.
- Stay bounded: a deeper refactor is a recommendation with its cost, not something you start.
- No edits in this pass. The user picks; then plan the fixes before touching code.
