# Specs

Spec Driven Development index of this repo. Workflow: skills `create-spec` and `review-spec`.
Layout: `docs/specs/{feature}/{name}.md`; answered questions in `docs/specs/{feature}/decisions/{name}.md`, cited by id (`Q-n`).
Status: `Not started` → `Draft` → `Approved` → `Implemented`. No code before `Approved`.
A spec covers one screen or one capability of one feature; behavior spanning two features is one spec per side.

| Feature | Spec | Scope | Status |
|---|---|---|---|
| foundations | [package-and-showcase](foundations/package-and-showcase.md) | Package skeleton, ported fundamentals, showcase apps, gate script | Implemented |
| foundations | [theme-and-tokens](foundations/theme-and-tokens.md) | Token tiers, standard theme, amendment, text size, `@MDS` and `mds` APIs, token inventory | Implemented |
| foundations | [foundations-pages](foundations/foundations-pages.md) | Showcase Foundations pages and playground Theme, Amendment, Text size controls | Draft |
| foundations | [primitives-in-design-system](foundations/primitives-in-design-system.md) | Primitive tier moved from DesignKit to DesignSystem, `internal` | Approved |
| components | activity-indicator | Activity indicator atom | Not started |
| components | action-button | Action button atom over `DK.ActionButton` | Not started |
| components | status-icon | Status icon component | Not started |
| components | inline-alert | Inline alert component | Not started |
| components | edge-case | Edge case molecule over `DK.EdgeCase`, wrapping `ContentUnavailableView` | Not started |
