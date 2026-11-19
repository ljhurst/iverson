---
name: weigh-plans
description: Draft two or three distinct plans for a change, weigh how each extends the existing code against over-engineering, and pick one. Use before implementing anything non-trivial, or when the user says "weigh the options", "challenge the plan", or "is this worth it". Read-only.
---

# Weigh plans

Before choosing, check what already exists: is there code, a tool or a pattern in this
repo that already does most of this?

Draft two or three plans that differ in approach, not in detail. Per plan, in a few lines:

- the approach and the files it touches;
- a signature or type sketch where the shape matters;
- how well it extends what is already here;
- its over-engineering risk;
- a verdict on whether it is worth doing at all.

Then pick one and say why in a sentence. Include "do less" as a plan when it is credible.

Be brief: the reader wants the choice and the reason, not an essay per option. Change
nothing.
