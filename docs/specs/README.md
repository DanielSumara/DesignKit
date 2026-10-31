# Specs

Spec Driven Development index of this repo. Workflow: skills `create-spec` and `review-spec`.
Layout: `docs/specs/{feature}/{name}.md` (spec id `{feature}/{name}`); answered questions in `docs/specs/{feature}/decisions/{name}.md`, cited by id (`Q-n`).
Status: `Not started` → `Draft` → `Approved` → `Planned` → `Implemented`. No code before `Approved`.
A spec covers one screen or one capability of one feature; behavior spanning two features is one spec per side.

| Feature | Spec | Scope | Status |
|---|---|---|---|
| foundations | [package-and-showcase](foundations/package-and-showcase.md) | Package skeleton, ported fundamentals, showcase apps, gate script | Implemented |
| foundations | [theme-and-tokens](foundations/theme-and-tokens.md) | Token tiers, standard theme, amendment, text size, `@MDS` and `mds` APIs, token inventory | Implemented |
| foundations | [foundations-pages](foundations/foundations-pages.md) | Showcase Foundations pages and playground Theme, Amendment, Text size controls | Implemented |
| foundations | [primitives-in-design-system](foundations/primitives-in-design-system.md) | Primitive tier moved from DesignKit to DesignSystem, `internal` | Implemented |
| components | [base-atoms](components/base-atoms.md) | Activity Indicator, Action Button, Status Icon: `DK.Status`, component tokens, DS components, showcase pages | Implemented |
| components | [base-molecules](components/base-molecules.md) | Inline Alert, Edge Case: `DK.InlineAlert`, component tokens, AccentTint mapping, String Catalog, DS components, showcase pages | Implemented |
| components | [modal-sheet](components/modal-sheet.md) | Modal Sheet template: `DK.ModalSheet`, header, Cancel and confirm placement per platform, discard confirmation, sizing tokens, showcase page | Draft |
| components | [form-fields](components/form-fields.md) | Form base and text field in `Forms/` folders: `DK.FormField`, `DK.SupportText`, Form Text Field, Field Row, Form Section, Form with focus order, showcase pages | Draft |
