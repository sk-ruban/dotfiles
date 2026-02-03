## Core Workflow: Research → Plan → Implement → Validate

Start every feature with: "Let me research the codebase and create a plan before implementing."

1. Research - Understand existing patterns and architecture
2. Plan - Propose approach and verify with you
3. Implement - Build with tests and error handling
4. Validate - ALWAYS run formatters, linters, and tests after implementation

---

# 0 — Purpose

These rules ensure maintainability, safety, and developer velocity.
**MUST** rules are enforced by CI; **SHOULD** rules are strongly recommended.

---

# 1 — Before Coding

- **A1 (SHOULD)** Ask the user clarifying questions.
- **A2 (SHOULD)** Draft and confirm an approach for complex work.
- **A3 (SHOULD)** If ≥ 2 approaches exist, list clear pros and cons.

---

# 2 — While Coding

- **B1 (MUST)** Name functions with existing domain vocabulary for consistency.
- **B2 (SHOULD NOT)** Introduce classes when small testable functions suffice.
- **B3 (SHOULD)** Prefer simple, composable, testable functions.
- **B4 (SHOULD NOT)** Add comments except for WHY decisions (business logic, performance tradeoffs, security considerations); rely on self‑explanatory code for WHAT.

---

# 3 — Git

- **C1 (MUST)** Use Conventional Commits format when writing commit messages: https://www.conventionalcommits.org/en/v1.0.0
- **C2 (SHOULD NOT)** Refer to AI tools (Claude, ChatGPT etc.) in commit messages.
- **C3 (SHOULD)** Include breaking change notes in commit body when applicable

---

# 4 — Swift / iOS Specific

- **D1 (SHOULD)** Use `@MainActor` for UI updates, never `DispatchQueue.main.async`
- **D2 (SHOULD)** Prefer computed properties over methods for simple transformations
- **D3 (SHOULD NOT)** Force unwrap (`!`) except for IBOutlets and genuinely impossible-to-fail cases
- **D4 (SHOULD)** Use proper error handling with `Result` types or `throws` instead of optionals for errors
- **D5 (SHOULD)** Follow Apple's SwiftUI data flow patterns (single source of truth)

---

# 5 — Performance & Security

- **E1 (SHOULD)** Use appropriate data structures (O(1) lookups vs O(n) searches)
- **E2 (SHOULD NOT)** Log sensitive data (API keys, user tokens, personal info)

# 6 — Bug fixes

- **F1 (SHOULD)** When fixing a bug, write a failing test that reproduces it before implementing the fix.

## Writing Functions Best Practices

When evaluating whether a function you implemented is good or not, use this checklist:

1. Can you read the function and HONESTLY easily follow what it's doing? If yes, then stop here.
2. Does the function have very high cyclomatic complexity? (number of independent paths, or, in a lot of cases, number of nesting if if-else as a proxy). If it does, then it's probably sketchy.
3. Are there any common data structures and algorithms that would make this function much easier to follow and more robust? Parsers, trees, stacks / queues, etc.
4. Is the function easily testable without mocking core features (e.g. sql queries, redis, etc.)? If not, can this function be tested as part of an integration test?
5. Does it have any hidden untested dependencies or any values that can be factored out into the arguments instead? Only care about non-trivial dependencies that can actually change or affect the function.
6. Does this function have a single, clear responsibility?
7. Are there any magic numbers that should be named constants?

IMPORTANT: you SHOULD NOT refactor out a separate function unless there is a compelling need, such as:
  - the refactored function is used in more than one place
  - the refactored function is easily unit testable while the original function is not AND you can't test it any other way
  - the original function is extremely hard to follow and you resort to putting comments everywhere just to explain it

## Writing Tests Best Practices

When evaluating whether a test you've implemented is good or not, use this checklist:

1. SHOULD Compare results to independent, pre-computed expectations with named constants—never unexplained literals or the function's own output.
2. SHOULD NOT add a test unless it can fail for a real defect. Trivial asserts (e.g., expect(2).toBe(2)) are forbidden.
3. SHOULD ensure the test description states exactly what the final expect verifies. If the wording and assert don’t align, rename or rewrite.
4. ALWAYS use strong assertions over weaker ones e.g. `expect(x).toEqual(1)` instead of `expect(x).toBeGreaterThanOrEqual(1)`.
5. SHOULD test edge cases, realistic input, unexpected input, and value boundaries.
6. SHOULD NOT test conditions that are caught by the type checker.

## Problem Solving

When stuck: Stop. The simple solution is usually correct.
When choosing: "I see approach A (simple) vs B (flexible). Which do you prefer?"

Your redirects prevent over-engineering. When uncertain about implementation, stop and ask for guidance.