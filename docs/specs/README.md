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
| foundations | [form-control-sizes](foundations/form-control-sizes.md) | Size primitives `size56`, `size320` for the Stepper and Field Row | Draft |
| components | [base-atoms](components/base-atoms.md) | Activity Indicator, Action Button, Status Icon: `DK.Status`, component tokens, DS components, showcase pages | Implemented |
| components | [base-molecules](components/base-molecules.md) | Inline Alert, Edge Case: `DK.InlineAlert`, component tokens, AccentTint mapping, String Catalog, DS components, showcase pages | Implemented |
| components | [modal-sheet](components/modal-sheet.md) | Modal Sheet template: `DK.ModalSheet`, header, Cancel and confirm placement per platform, discard confirmation, sizing tokens, showcase page | Implemented |
| components | [form-fields](components/form-fields.md) | Form base and text field in `Forms/` folders: `DK.FormField`, `DK.SupportText`, Form Text Field, Field Row, Form Section, Form, showcase pages | Implemented |
| components | [view-state](components/view-state.md) | View State organism: `DS.ViewState` over `DK.ViewState`, delayed loading indicator with label, edge case, loaded content, component tokens, showcase page | Implemented |
| components | [form-focus-moves](components/form-focus-moves.md) | Nice-to-have: Return moves the focus to the next form field, scrolled in | Not started |
| components | [text-input](components/text-input.md) | Text Input: `DS.FormTextField` renamed `DS.TextInput`, multi-line, alignment from the environment | Draft |
| components | [form-field-row](components/form-field-row.md) | Field Row renamed `DS.FormField`, supplementary text replaces Optional, control area at regular width, compact error leading | Draft |
| components | [money-inputs](components/money-inputs.md) | Amount Input and Currency Picker: `DK.CurrencyOption`, display styles, decimal keyboard | Draft |
| components | [choice-pickers](components/choice-pickers.md) | Option Picker and native Segmented Control, generic options | Draft |
| components | [stepper](components/stepper.md) | Stepper: typed or stepped whole number in bounds, prefix and suffix, `stepper.valueFieldWidth` | Draft |
| components | [date-picker](components/date-picker.md) | Date Picker: native compact date picker, optional range | Draft |
| components | [modal-sheet-height](components/modal-sheet-height.md) | Modal Sheet: macOS `height` override | Draft |
