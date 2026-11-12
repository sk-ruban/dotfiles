---
paths:
  - "**/*.swift"
---

# Swift

- Use `@MainActor` for UI updates, not `DispatchQueue.main.async`.
- Don't force unwrap (`!`) unless failure is genuinely impossible (IBOutlets aside).
- Report errors with `throws` or `Result`, not optionals.
- Prefer computed properties over methods for simple transformations.
- Follow SwiftUI's single-source-of-truth data flow.
