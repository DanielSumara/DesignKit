# Form field row
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: components/form-fields, components/text-input, foundations/form-control-sizes

## Goal
The Field Row as approved on 1 November 2026: `DS.FieldRow` becomes `DS.FormField`, the ViewModel's supplementary text replaces the fixed Optional qualifier, the control trails in an area of at least 320 pt at regular width with a text control's text trailing, and an error reads leading at compact width. Form Section and Form keep their behavior and take the new row.

## Scope
- In:
  - `DS.FieldRow` renamed `DS.FormField`; `DK.FormField.isOptional` replaced by `supplementaryText`
  - Regular-width layout: title, spacer, control area; trailing text alignment for the control
  - Compact-width error alignment
  - Component token `fieldRow.controlMinWidth`; copy key `designSystem.fieldRow.optional` removed
  - Showcase pages Field Row, Form Section and Form on the new names; the Field Row page's control picker as a slot for other controls
  - form-fields BR-6, BR-7, BR-11 and BR-14 marked superseded where this spec changes them, once implemented
- Out:
  - Focus, Return, sections and the form (form-fields BR-3, BR-4, BR-5, BR-9: unchanged)
  - The controls a row hosts: components/text-input, components/money-inputs, components/choice-pickers, components/stepper, components/date-picker; each adds itself to the Field Row page's control picker
  - The Optional copy itself: each app's ViewModel (HomeBudgetApps)

## User stories
- US-1 As a user I want labels on the left and values lined up on the right in a wide form so that I scan a form quickly.
- US-2 As a developer I want to give a field any short note after its title (Optional, a unit, a hint) from my ViewModel so that the design system holds no feature copy.

## Data
- `DK.FormField<Value: Equatable>`: as form-fields Data, with `isOptional` replaced by:
  - supplementaryText: `String?` — display-ready, drawn after the title; default nil
- `DS.FormField(field: Binding<DK.FormField<Value>>, @ViewBuilder content: (Binding<Value>) -> Control)`
- Component tokens `fieldRow`: as form-fields Data, plus `controlMinWidth` → size320 (text-bound, scales)
- Semantic, no tokens of their own: supplementary text Typography.footnote in Foreground.tertiary; spacer at least Spacing.small

## Rules
- BR-1 Rename: `DS.FormField(field:content:)` replaces `DS.FieldRow(_:control:)` with no alias kept; component configuration `fieldRow` and copy key `designSystem.fieldRow.error` keep their names (Q-1).
- BR-2 Supplementary text: `isOptional` and the key `designSystem.fieldRow.optional` are removed. A non-empty `supplementaryText` is drawn after the title, on its first baseline, in Data's look, at both widths; nil or empty draws nothing.
- BR-3 Regular width (form-fields BR-6's condition): the title leads, then a flexible spacer at least Spacing.small, then the control area, trailing, at least `controlMinWidth` wide and as wide as the control's ideal width beyond it; title and control aligned on their first baselines. The row sets trailing multiline text alignment for its control (components/text-input BR-3).
- BR-4 Compact width: stacked as form-fields BR-6 (title with supplementary text, control, support text); the control keeps leading alignment; an error is aligned leading, a footnote leading and a message trailing.
- BR-5 Accessibility: the control's label is the title followed by the supplementary text; errors, footnotes, messages and the error announcement as form-fields BR-7.
- BR-6 A size-class change switches BR-3 and BR-4 in place, keeping focus, keyboard and text (form-fields BR-6).
- BR-7 Configuration: `controlMinWidth` is a property of `fieldRow` in every built-in theme, on the scaling list (theme-and-tokens BR-7).
- BR-8 Previews: light and dark previews of a row at regular and compact width with supplementary text, a footnote, a message and an error.
- BR-9 Showcase pages: Field Row: title, supplementary text, support text kind and text, and a control picker (Text Input; each control spec adds its own); Form Section and Form as form-fields BR-14 with the second field's "Optional" given as supplementary text; theme, amendment, appearance, text size and the live `DK.FormField(…)` snippet as before.
- BR-10 Lifecycle: approved only once the canvas pages "Molecule · Field Row", "Organism · Form Section" and "Template · Form" are `Approved`; once the showcase pages are done, the Field Row canvas header shows Implemented, `components.md` entries are updated, and the superseded form-fields rules carry a note naming this spec.

## Acceptance criteria
- AC-1 (manual) Given a field with supplementary text "Optional", when shown at regular and compact width, then the text follows the title in the footnote style and tertiary color; with nil or "", nothing follows the title (BR-2).
- AC-2 (manual) Given a form on macOS with a text field and a short picker in two rows, when shown, then each title leads, each control area trails and is at least 320 pt wide at 100 % text size, and the text field's text is trailing (BR-3).
- AC-3 (manual) Given a control whose ideal width exceeds `controlMinWidth`, when shown at regular width, then its area grows to fit it and the title keeps at least Spacing.small to it (BR-3).
- AC-4 (manual) Given macOS text size 200 %, when the form is shown, then the control area's minimum width grows with the text size (BR-7).
- AC-5 (manual) Given an iPhone in portrait, when a field shows an error, a footnote and then a message, then the error and the footnote are leading and the message trailing below the control; on an iPad full screen the error is trailing (BR-3, BR-4).
- AC-6 (manual) Given a focused field with typed text on an iPad, when the app enters Split View at compact width and back, then focus, keyboard and text remain (BR-6).
- AC-7 (manual) Given VoiceOver, when a field with supplementary text "Optional" and an error gets the focus, then the title, "Optional" and the error are read in that order (BR-5).
- AC-8 (manual) Given the showcase pages, when each Playground control changes, then the row and its snippet follow it, Variants show light and dark, Configuration shows `controlMinWidth` → size320, and the Xcode previews show the BR-8 cases (BR-8, BR-9).
- AC-9 (manual) Given the finished pages, when checked, then no `FieldRow(` call, `isOptional` or `designSystem.fieldRow.optional` remains in the package, DemoApps or the String Catalog, the canvas header shows Implemented and `components.md` names `DS.FormField` (BR-1, BR-2, BR-10).

## Open questions
- Q-1 The canvas renames the type to `DS.FormField` but keeps `fieldRow` in its token chains and the page name "Field Row". Keep `fieldRow` and `designSystem.fieldRow.error` (drafted), or rename them to `formField` with the type?

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Molecule · Field Row", "Organism · Form Section", "Template · Form" (Approved 1 November 2026) (create-spec)
