Invoke the @code-simplifier:code-simplifier agent on all staged and unstaged changes.

If code-simplifier finds issues worth addressing, report them and wait for instructions.

Otherwise:
1. Stage only the relevant changed files (never blindly `git add -A`)
2. Write a Conventional Commits message (`feat:`, `fix:`, `chore:`, etc.)
3. Commit

After committing, if a PLAN.md exists in the repo root, mark any completed items as done (matching its existing format). Do not add or remove items. If no items match the committed changes, leave PLAN.md unchanged.
