# Text input
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignSystem, DemoApps · Depends on: components/form-fields

## Goal
The native text field atom for any typed text, not only in forms: `DS.FormTextField` becomes `DS.TextInput`, gains several lines for a free-form note (HomeBudgetApps reminder form) and takes its text alignment from its environment, so a Field Row can set its text trailing.

## Scope
- In:
  - `DS.FormTextField` renamed `DS.TextInput`, moved from `Sources/DesignSystem/Forms/` to the DesignSystem atoms at the target root; `docs/architecture.md` §2 updated
  - `lines` parameter: one line by default, more for a wrapping multi-line field
  - Text alignment from the environment
  - Showcase page "Form Text Field" renamed "Text Input"; `components.md` entry renamed
  - form-fields BR-8 and BR-14's Form Text Field page marked superseded by this spec once implemented
- Out:
  - The error look's drawing and tokens, kept as they are (form-fields BR-8, BR-10); the row deciding the error (components/form-field-row)
  - Trailing alignment inside a Field Row at regular width: the row sets it (components/form-field-row)
  - Formatting, parsing, input masks, character limits: each Core
  - Amounts: components/money-inputs

## User stories
- US-1 As a user I want to type a longer note on several visible lines so that I can read it all while I write.
- US-2 As a developer I want one text field atom for any typed text, inside a form or not, so that every text input looks the same.

## Data
- `DS.TextInput(text: Binding<String>, prompt: String? = nil, lines: Int = 1)`
- No component tokens; error look tokens are `fieldRow`'s (form-fields Data)

## Rules
- BR-1 Rename: `DS.TextInput` replaces `DS.FormTextField` with no alias kept; every DemoApps use is updated; the behavior of form-fields BR-8 is kept unchanged except as BR-2 and BR-3 here.
- BR-2 Lines: `lines` 1 draws the native single-line field. Above 1, a native vertical-axis text field that wraps and reserves the height of `lines` lines whatever its text; longer text scrolls inside it. Values below 1 draw one line.
- BR-3 Alignment: the text and prompt follow the environment's multiline text alignment, leading by default; the field sets none of its own.
- BR-4 Return: a single-line field keeps form-fields BR-5. In a multi-line field Return behaves as the native vertical-axis text field does on each platform (Q-1).
- BR-5 Placement: the file is `Sources/DesignSystem/DS+TextInput.swift`, beside the other atoms; `docs/architecture.md` §2 lists the `Forms/` folder without it.
- BR-6 Previews: light and dark previews of an empty field with prompt, typed text, a 3-line field with wrapping text, trailing alignment and the error look.
- BR-7 Showcase page "Text Input" under Atoms: Playground with prompt, text, lines (1 to 5), alignment (leading, trailing), error (sets `fieldShowsError`) and disabled, plus theme, amendment, appearance and text size, with the live `DS.TextInput(…)` snippet; Variants: BR-6 cases light and dark; Configuration: the error look's `fieldRow` token chains.
- BR-8 Lifecycle: approved only once the canvas page "Atom · Text Input" is `Approved`; once the showcase page is done, the canvas header shows Implemented, `components.md` gets the renamed entry, and form-fields BR-8 and BR-14 note "Text Input superseded by components/text-input".

## Acceptance criteria
- AC-1 (manual) Given a field with a prompt and `lines` 1, when empty, then the prompt shows; when typed into, then the bound text is exactly the typed text (BR-1, BR-2).
- AC-2 (manual) Given `lines` 3, when shown empty, then the field is three lines tall; when a text of six lines is typed, then it wraps, the field stays three lines tall and the text scrolls inside it (BR-2).
- AC-3 (manual) Given the environment alignment trailing, when text is typed, then the text and prompt are trailing; with no alignment set, leading (BR-3).
- AC-4 (manual) Given `fieldShowsError` true and the field focused, when shown on macOS, iPadOS and iOS, then the critical border and critical focus ring of form-fields BR-8 are drawn for one line and for three lines (BR-1, BR-2).
- AC-5 (manual) Given a disabled container, when the user tries to type in a single-line or multi-line field, then it takes no input (BR-1).
- AC-6 (manual) Given macOS text size 200 % or iOS at the largest accessibility Dynamic Type size, when a 3-line field is shown, then its text and its reserved height grow with it (BR-2).
- AC-7 (manual) Given the showcase page, when each Playground control changes, then the field and its snippet follow it, Variants show the BR-6 cases light and dark, and the Xcode previews show the same (BR-6, BR-7).
- AC-8 (manual) Given the finished showcase page, when checked, then no `FormTextField` name remains in the package or DemoApps, the canvas page shows Implemented, `components.md` and architecture §2 name `DS.TextInput`, and form-fields BR-8 and BR-14 carry the superseded note (BR-1, BR-5, BR-8).

## Open questions
- Q-1 On iOS, Return in a multi-line field inserts a new line natively, while form-fields BR-5 makes the return key read Done. Keep the native new line for multi-line fields, or keep Done and no new lines?

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Atom · Text Input" (Approved 1 November 2026) (create-spec)
