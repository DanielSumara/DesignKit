# Choice pickers
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignSystem, DemoApps · Depends on: components/form-fields, components/form-field-row

## Goal
Two native atoms for choosing one of several options of any generic type: `DS.OptionPicker`, a pop-up menu for five or more choices (a weekday, a month), and `DS.SegmentedControl`, a segmented control for two to four short, always-visible choices (a frequency).

## Scope
- In:
  - `DS.OptionPicker`, `DS.SegmentedControl`, generic over `Option`
  - Canvas pages "Atom · Option Picker", "Atom · Segmented Control"; showcase pages under Atoms; both added to the Field Row page's control picker (components/form-field-row BR-9); `components.md` entries
- Out:
  - A custom-drawn segmented control and its tokens (Q-1)
  - Option icons, sections or separators in the menu, multiple selection, search: a later spec when a screen needs them
  - Localizing option titles: the `Option` type's description, built in the feature's Core

## User stories
- US-1 As a user I want to pick one of many choices from a menu so that the form stays compact.
- US-2 As a user I want two to four choices side by side so that I see them all and switch with one tap.
- US-3 As a developer I want to pass my own enum as the options so that the selection is typed, not a string.

## Data
- `Option: Hashable & CustomStringConvertible`; its `description` is the display-ready title
- `DS.OptionPicker(selection: Binding<Option>, options: [Option])`
- `DS.SegmentedControl(selection: Binding<Option>, options: [Option])`
- No component tokens: both are native controls (Q-1)

## Rules
- BR-1 Titles: each option reads its `description`; options show in the given order.
- BR-2 Option Picker: the native menu-style picker (macOS pop-up button), sized to its content; the button reads the selection's title, the menu lists every option with the selection checked; choosing one sets `selection`.
- BR-3 Segmented Control (Q-1): the native segmented picker in the system look with the theme's tint, sized to its content, never wrapping; one segment per option, the selection's segment selected; tapping or clicking another sets `selection`. Two to four options is usage guidance on the canvas, not enforced.
- BR-4 Both: their own label hidden, the accessibility label the row's (components/form-field-row BR-5) and the value the selection's title; disabled by the environment; the Option Picker takes focus (form-fields BR-4), the Segmented Control as the platform's segmented control does; no error look.
- BR-5 Previews: light and dark previews of the Option Picker over weekdays and over months, and of the Segmented Control with two, three and four options, each also disabled.
- BR-6 Showcase pages under Atoms: Option Picker (sample: weekdays, months), Segmented Control (sample: two, three or four options) with disabled, theme, amendment, appearance, text size, the selection shown below and the live snippet; Variants: BR-5 cases light and dark. The Field Row page's control picker gains "Option Picker" and "Segmented Control".
- BR-7 Lifecycle: approved only once both canvas pages are `Approved`, the Segmented Control page's token list replaced by "native segmented control, system look, theme tint" (Q-1); once the showcase pages are done, the canvas headers show Implemented and `components.md` gets the entries.

## Acceptance criteria
- AC-1 (manual) Given an Option Picker over the seven weekdays with Monday selected, when shown on macOS, iPadOS and iOS, then the button reads Monday and is as wide as its text and arrows; when opened, then the seven weekdays show in order with Monday checked (BR-1, BR-2).
- AC-2 (manual) Given the open menu, when Friday is chosen, then the selection becomes Friday and the button reads it (BR-2).
- AC-3 (manual) Given a Segmented Control with three options, when shown, then three segments in order are drawn in the system look with the selected one marked, as wide as their titles; when another is tapped or clicked, then the selection follows (BR-3).
- AC-4 (manual) Given a Segmented Control with four long titles at the largest text size, when shown, then it stays one line (BR-3).
- AC-5 (manual) Given a disabled container, when the user tries either control, then neither changes and both draw disabled (BR-4).
- AC-6 (manual) Given VoiceOver, when either control in a row titled "Repeat" is focused, then "Repeat" and the selected title are read (BR-4).
- AC-7 (manual) Given the Field Row page with each control, when shown at regular width, then it trails in the control area (BR-6).
- AC-8 (manual) Given the showcase pages, when each Playground control changes, then the controls and snippets follow it, Variants and the Xcode previews show the BR-5 cases light and dark; the finished pages leave the canvas headers Implemented and `components.md` with the entries (BR-5, BR-6, BR-7).

## Open questions
- None.

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Atom · Option Picker", "Atom · Segmented Control" (Approved 1 November 2026); native segmented control (Q-1) (create-spec)
