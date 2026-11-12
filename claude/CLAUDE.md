# Working style

- Research existing patterns before changing code. For non-trivial work, propose an approach and confirm it before implementing; small fixes don't need a plan.
- When several approaches are viable, recommend one first, then for each alternative explain what it means, its pros and cons, and when you'd choose it.
- Make reasonable assumptions and proceed. Ask only when a decision is blocking or risky, and prefer a short plain question over a multiple-choice list.
- When stuck, step back: the simple solution is usually the right one.
- After implementing, run the project's formatter, linter and tests, and say what you ran.

# Code

- Name things with the codebase's existing domain vocabulary.
- Prefer small, composable functions over classes.
- Don't extract a function unless it's reused, it makes otherwise untestable logic testable, or the original is genuinely hard to follow.
- Prefer data structures with O(1) lookups over repeated O(n) searches.
- Replace magic numbers with named constants.
- Comment only the non-obvious why (business rules, performance tradeoffs, security), as a short line. Put longer rationale in the chat reply.
- Never log secrets, tokens or personal data.

# Tests

- For a bug fix, write a failing test that reproduces it before fixing it.
- Assert against independent, precomputed expectations held in named constants, never the function's own output.
- Only add tests that can fail for a real defect: no tautological asserts, nothing the type checker already catches.
- Use the strongest assertion available: `toEqual(1)`, not `toBeGreaterThanOrEqual(1)`.
- A test's name states exactly what its final assertion checks.
- Cover realistic input, edge cases, boundaries and unexpected input.

# Git

- Commit messages follow Conventional Commits, with breaking-change notes in the body.
- Don't mention AI tools or add AI co-author trailers in commits or PRs.
- Open PRs assigned to me: `gh pr create --assignee @me`.
