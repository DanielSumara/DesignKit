# Stepper
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignSystem, DemoApps · Depends on: components/text-input, components/form-field-row, foundations/form-control-sizes

## Goal
An atom for a small whole number within clear bounds (every N months, the day of the month, days before): an editable value field with the native stepper beside it and an optional unit text before or after it.

## Scope
- In:
  - `DS.Stepper`, generic over a `BinaryInteger` value
  - Component configuration `stepper`
  - Canvas page "Atom · Stepper"; showcase page under Atoms; added to the Field Row page's control picker (components/form-field-row BR-9); `components.md` entry
- Out:
  - Decimal or unbounded values: components/money-inputs
  - Steps other than one, acceleration on hold beyond the platform's own: a later spec when a screen needs it
  - Pluralizing the unit text with the value: the ViewModel's copy

## User stories
- US-1 As a user I want to type a number or nudge it up and down so that I set small values quickly either way.
- US-2 As a user I want the field to keep my number within its bounds so that I can't enter an impossible day.

## Data
- `DS.Stepper<Value: BinaryInteger>(value: Binding<Value>, range: ClosedRange<Value>, prefix: String? = nil, suffix: String? = nil)`
- Component tokens `stepper`: `valueFieldWidth` → size56 (text-bound, scales)
- Semantic, no tokens of their own: prefix and suffix Typography.body in Foreground.secondary

## Rules
- BR-1 Layout: prefix, value field, native stepper buttons, suffix, in one line, each piece only when present, spaced as the platform's stepper with a field; nil or empty prefix or suffix draws nothing.
- BR-2 Value field: the single-line Text Input look (components/text-input BR-1), `valueFieldWidth` wide, text trailing, showing the value in the locale's integer format (Q-1); iOS and iPadOS show the number pad.
- BR-3 Typing: the typed text is committed when Return is pressed or the field loses the focus; a number outside `range` is clamped to the nearer bound, text that is no whole number restores the last value; `value` changes only on commit.
- BR-4 Buttons: each press changes the value by one; at a bound its button is disabled.
- BR-5 The value field takes focus (form-fields BR-4); disabled by the environment, value in Foreground.disabled and both buttons inert; no error look.
- BR-6 Accessibility: one adjustable element with the row's label (components/form-field-row BR-5), the value with prefix and suffix as its value, increment and decrement as the buttons.
- BR-7 Configuration: `valueFieldWidth` is a property of `stepper` in `DS.Theme.Components` in every built-in theme, read only through `@MDS(\.stepper)`, on the scaling list (theme-and-tokens BR-7).
- BR-8 Previews: light and dark previews with a suffix, with a prefix, at each bound and disabled.
- BR-9 Showcase page "Stepper" under Atoms: Playground with value, lower and upper bound, prefix, suffix and disabled, plus theme, amendment, appearance and text size, with the live `DS.Stepper(…)` snippet; Variants: BR-8 cases light and dark; Configuration: `valueFieldWidth` → size56. The Field Row page's control picker gains "Stepper".
- BR-10 Lifecycle: approved only once the canvas page "Atom · Stepper" is `Approved`; once the showcase page is done, the canvas header shows Implemented and `components.md` gets the entry.

## Acceptance criteria
- AC-1 (manual) Given range 1...28, value 15 and prefix "Day", when shown on macOS, iPadOS and iOS, then "Day", a 56 pt field reading 15 trailing, and the stepper buttons show in one line (BR-1, BR-2).
- AC-2 (manual) Given value 28 in 1...28, when shown, then the increment button is disabled; when decrement is pressed, then the value is 27 and both buttons are enabled (BR-4).
- AC-3 (manual) Given the field focused, when "40" is typed and Return pressed, then the value is 28; when "abc" is typed and the focus leaves, then the field shows the last value again and `value` is unchanged (BR-3).
- AC-4 (manual) Given the field focused on iPhone, when typing, then the number pad shows (BR-2).
- AC-5 (manual) Given a disabled container, when the user types or presses a button, then nothing changes and the value draws disabled (BR-5).
- AC-6 (manual) Given VoiceOver in a row titled "Every", when the stepper is focused and swiped up, then "Every", the value with its suffix are read and the value goes up by one (BR-6).
- AC-7 (manual) Given macOS text size 200 %, when shown, then the value field is wider in proportion and a two-digit value fits (BR-7).
- AC-8 (manual) Given the showcase page, when each Playground control changes, then the stepper and its snippet follow it, Variants and the Xcode previews show the BR-8 cases light and dark, Configuration shows the token chain; the finished page leaves the canvas header Implemented and `components.md` with the entry (BR-8, BR-9, BR-10).

## Open questions
- Q-1 The canvas says the value is "formatted by the ViewModel's format style", but the API takes no format. Keep the locale's integer format inside the control (drafted), or add a `format` parameter?
- Q-2 `DS.Stepper` shares its name with SwiftUI's `Stepper` (form-fields BR-2 forbids that for form types; `DS.Form` already does). Keep the canvas name, or rename (`DS.NumberStepper`)?

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Atom · Stepper" (Approved 1 November 2026) (create-spec)
