# Date picker
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignSystem, DemoApps · Depends on: components/form-fields, components/form-field-row

## Goal
An atom for a single calendar day: the native compact date picker, which shows the date in the system's format and opens the native calendar in a popover, optionally bounded.

## Scope
- In:
  - `DS.DatePicker`
  - Canvas page "Atom · Date Picker", redrawn in the native look (Q-1); showcase page under Atoms; added to the Field Row page's control picker (components/form-field-row BR-9); `components.md` entry
- Out:
  - The long date format of the canvas (Q-1)
  - A time of day, a date range, a time zone other than the environment's: a later spec when a screen needs it

## User stories
- US-1 As a user I want to pick a day from a calendar or type it so that I set a date the way I prefer.
- US-2 As a user I want days outside the allowed range unavailable so that I can't pick a date the app would refuse.

## Data
- `DS.DatePicker(selection: Binding<Date>, range: ClosedRange<Date>? = nil)`
- No component tokens: the control is native

## Rules
- BR-1 Look (Q-1): the native date picker in the compact style, date only, in the system's date format, locale, calendar and time zone of the environment, with the theme's tint; sized to its content.
- BR-2 Selection: picking a day in the calendar or editing the date in the field sets `selection`; the time part of `selection` is the platform's.
- BR-3 Range: with a `range`, days outside it are not selectable in the calendar or the field; nil leaves the date unbounded.
- BR-4 The control takes focus (form-fields BR-4); disabled by the environment; no error look; its own label hidden, the accessibility label the row's (components/form-field-row BR-5).
- BR-5 Previews: light and dark previews of a date, a date bounded to the next 30 days, and disabled.
- BR-6 Showcase page "Date Picker" under Atoms: Playground with the date, a range toggle (today to 30 days ahead) and disabled, plus theme, amendment, appearance and text size, the selection shown below and the live `DS.DatePicker(…)` snippet; Variants: BR-5 cases light and dark. The Field Row page's control picker gains "Date Picker".
- BR-7 Lifecycle: approved only once the canvas page "Atom · Date Picker" is redrawn in the native compact look and `Approved` again (Q-1); once the showcase page is done, the canvas header shows Implemented and `components.md` gets the entry.

## Acceptance criteria
- AC-1 (manual) Given a date picker on macOS, iPadOS and iOS in Polish and English, when shown, then it is the native compact picker with the date in the system's format for that language (BR-1).
- AC-2 (manual) Given the picker, when activated and another day is picked in the calendar, then `selection` is that day and the picker shows it (BR-2).
- AC-3 (manual) Given a range from today to 30 days ahead, when the calendar is opened, then days outside it can't be picked (BR-3).
- AC-4 (manual) Given a disabled container, when the user activates the picker, then no calendar opens and it draws disabled (BR-4).
- AC-5 (manual) Given VoiceOver in a row titled "Start date", when the picker is focused, then "Start date" and the date are read (BR-4).
- AC-6 (manual) Given the showcase page, when each Playground control changes, then the picker and its snippet follow it, Variants and the Xcode previews show the BR-5 cases light and dark; the finished page leaves the canvas header Implemented and `components.md` with the entry (BR-5, BR-6, BR-7).

## Open questions
- Q-2 `DS.DatePicker` shares its name with SwiftUI's `DatePicker` (form-fields BR-2 forbids that for form types; `DS.Form` already does). Keep the canvas name, or rename (`DS.DayPicker`)?

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Atom · Date Picker" (Approved 1 November 2026); native compact look, no long format (Q-1) (create-spec)
