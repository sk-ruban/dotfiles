Review all staged and unstaged changes for issues. Look for:
- Logic errors or bugs
- Missing error handling
- Inconsistent naming or style
- Dead code or unnecessary complexity

Then invoke the @code-simplifier:code-simplifier agent to refine the changed code.

After code-simplifier completes, if there are no warnings, errors, or issues worth addressing:
1. Stage all changes
2. Write a concise, conventional commit message describing the changes
3. Commit

If there ARE issues, report them and wait for instructions before committing.