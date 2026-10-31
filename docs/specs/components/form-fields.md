# Form fields
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: components/base-atoms, foundations/theme-and-tokens, foundations/package-and-showcase

## Goal
The first form components of DesignSystem, enough for a form of text fields such as HomeBudgetApps reminders/configure-reminders/reminder-form: the field data object a ViewModel fills, a text field, the field row around any control (label, optional qualifier, footnote, message or error text), a section and the form owning the focus order. They live in a `Forms/` folder of DesignKit and DesignSystem, not in packages of their own (Q-1).

## Scope
- In:
  - `DK.FormField<Value: Equatable>`, `DK.SupportText`, in `Sources/DesignKit/Forms/`
  - In `Sources/DesignSystem/Forms/`: `DS.FormTextField` (atom), `DS.FieldRow` (molecule), `DS.FormSection` (organism), `DS.Form` (template); the environment value `fieldShowsError`
  - Component configuration `fieldRow` in `DS.Theme.Components`
  - DesignSystem String Catalog keys for the optional qualifier and the error announcement
  - Canvas pages "Atom · Form Text Field", "Molecule · Field Row", "Organism · Form Section", "Template · Form"; showcase pages; `components.md` entries once implemented
  - `docs/architecture.md` §2 Layout: the `Forms/` folders
- Out:
  - Amount, date, picker, toggle and other inputs, change cues and toggle buttons on a field: a later spec (components/form-inputs)
  - Validation rules and binding them to `DK.FormField` (HomeBudgetApps forms/validated-fields, UtilitiesKit validation/validators); parsing and formatting values (UtilitiesKit, each Core)
  - Moving the focus to a field with an error (Q-4)
  - Presenting a form in a sheet (components/modal-sheet)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Pole formularza | Form field | One edited value with its label and help or error text, filled by a ViewModel |
| Tekst pomocniczy | Support text | The line below a field's control: a footnote, a message or an error |
| Kwalifikator | Qualifier | The word after a field's label marking it optional |

## User stories
- US-1 As a user I want each field labelled, with its help or error right below it, so that I know what to enter and what to fix.
- US-2 As a user I want Return to take me to the next field so that I fill a form without reaching for the mouse or the screen.
- US-3 As a developer I want forms built from DesignSystem components over `DK.FormField` so that every form looks and moves focus the same way, a ViewModel drives the errors and hears every focus change.

## Data
- `DK.FormField<Value: Equatable>` (`Equatable` over every property but `onFocusChange`; `Sendable` where `Value` is):
  - title: `String` — display-ready label, not empty
  - value: `Value` — the edited value as the control edits it (text for a text field)
  - isOptional: `Bool` — draws the qualifier of Copy after the title; default false
  - supportText: `DK.SupportText?` — default nil
  - isHidden: `Bool` — not drawn, not in the focus order; default false
  - onFocusChange: `@MainActor @Sendable (Bool) -> Void` — built by the ViewModel, called by the form (BR-4); default does nothing
- `DK.SupportText` (`Equatable`, `Sendable`): `footnote(String)` describes the item, `message(String)` describes an effect, `error(String)` names what to fix
- `DS.FormTextField(text: Binding<String>, prompt: String?)`; `DS.FieldRow(_ field: Binding<DK.FormField<Value>>, @ViewBuilder control: (Binding<Value>) -> Control)`; `DS.FormSection(_ title: String?, footer: String? = nil, @ViewBuilder content:)`; `DS.Form(@ViewBuilder content:)`
- `EnvironmentValues.fieldShowsError: Bool` — public to read, set only by `DS.FieldRow` for its control; false outside a row
- Component tokens `fieldRow`: `supportTextColor(kind)` footnote and message → Foreground.secondary, error → Foreground.critical; `errorBorderColor` → Border.critical; `errorBorderWidth` → BorderWidth.thin; `errorBorderRadius` → Radius.small; `supportSpacing` → Spacing.xxSmall
- Semantic, no tokens of their own: title Typography.body in Foreground.primary; qualifier Typography.body in Foreground.tertiary; support text and section footer Typography.footnote

## Rules
- BR-1 Port: the code starts from FinanceTracker `Kits/DesignKit/Sources/DesignKit/DK+FormField.swift`, `DK+SupportText.swift`, `DesignKitUI/Molecules/DS+FieldRow.swift`, `DesignKitUI/Organisms/DS+FormSection.swift` and `DesignKitUI/Support/FormFocus.swift`; `DS.FormTextField` and `DS.Form` are new. The public API is Data's, the look the canvas pages'. Not ported: the two-way `hasFocus` and FormFocus's requests and error targets (Q-8, Q-4); `qualifier: String?` (`isOptional` with DesignSystem's copy instead); `showsLabel:`, the read-only presentation initializer, `changeCue`, `toggleButton`, `reportsFocus(into:)`, `numberFieldWidth()` (components/form-inputs, where needed); `SupportText.footer` (the section owns its footer); the error icon.
- BR-2 Placement (Q-1): form types live in `Forms/` folders of the DesignKit and DesignSystem targets, in the flat `DK` and `DS` namespaces; the catalogue, canvas and showcase group them by atomic level like every other component; no type name equals a SwiftUI one.
- BR-3 Form: the native grouped form style on every platform, its sections in order; it scrolls on its own (components/modal-sheet BR-8) and keeps the focused field in view.
- BR-4 Focus (Q-8): the form owns the focus; a ViewModel never sets it. When a field's control gains the focus the form calls its `onFocusChange(true)`, when it loses it `onFocusChange(false)`; at most one field has it. When the form appears no field has the focus (Q-9). A focused field that becomes hidden or is removed loses the focus, which leaves the form. A Mac window or app losing key status keeps the field's focus and calls nothing.
- BR-5 Return (Q-6): macOS: in a text field Return moves the focus to the next visible field of the form in order; in the last one it leaves the focus where it is and reaches the default action (base-atoms BR-5). iOS and iPadOS: the return key reads Next on every visible field but the last and Done on the last; Next moves the focus as on macOS, Done hides the keyboard and the field loses the focus. Tab follows the same order natively.
- BR-6 Field row (Q-3, Q-5): macOS and iPadOS the platform's labelled form row (label leading, control trailing, native widths); iOS stacked: title with the qualifier, the control, the support text. The title and, when `isOptional`, the qualifier in Data's look; the support text below the control, `supportSpacing` apart, in `supportTextColor` of its kind, a footnote aligned leading, a message and an error trailing; a field with an error sets `fieldShowsError` true for its control; a hidden field draws nothing.
- BR-7 Accessibility: the control's label is the title (with the qualifier when optional); an error is read after the label as the control's hint; a footnote or message as its hint when there is no error. When a field's support text becomes an error, or another error, while its control has the focus, VoiceOver announces the copy `designSystem.fieldRow.error` with the title and the error (Q-7).
- BR-8 Text field (Q-5): the native single-line text field in the rounded-border style on every platform, with an optional prompt; it edits the text as typed, no formatting or parsing (each Core's); when `fieldShowsError` is true it draws a border of `errorBorderColor`, `errorBorderWidth` and `errorBorderRadius` over its native one, the focus ring staying the system's; disabled by the environment like any native control.
- BR-9 Section: the native form section with an optional title as header and an optional footer below it; nil or empty draws nothing.
- BR-10 Configuration: every token of Data is a property of `fieldRow` in `DS.Theme.Components`, read only through `@MDS(\.fieldRow)`.
- BR-11 Copy: keys `designSystem.fieldRow.optional` and `designSystem.fieldRow.error` in DesignSystem's String Catalog, pl and en (Copy).
- BR-12 Previews: each component file has light and dark previews; the form preview shows two sections, an optional field, a footnote, a message and an error.
- BR-13 Lifecycle: the spec is approved only once its four canvas pages are `Approved` (Q-2); once the showcase pages are done, the canvas headers show Implemented and `components.md` gets the entries; the slice adding the folders updates `docs/architecture.md` §2.
- BR-14 Showcase pages, under their atomic levels: Form Text Field (prompt, text, error), Field Row (title, isOptional, support text kind and text, hidden), Form Section (title, footer, rows), Form (two sections of three fields in a frame shorter than the form; toggles for the third field hidden, the form disabled, the second field optional with an error; a primary Action Button; a log of the `onFocusChange` calls); each with theme, amendment, appearance and text size, the live `DK.FormField(…)` snippet where the page shows one, Variants light and dark, Configuration with the `fieldRow` token chains.

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.fieldRow.optional | Opcjonalne | Optional |
| designSystem.fieldRow.error | Błąd: %1$@, %2$@ | Error: %1$@, %2$@ |

## Acceptance criteria
- AC-1 (manual) Given a form of two sections on macOS, iPadOS and iOS, when shown, then it uses the grouped form style, sections in order with their titles and footers, and scrolls when taller than its space (BR-3, BR-9).
- AC-2 (manual) Given a field row with `isOptional` true, when shown, then its title is followed by the qualifier in Polish and English (BR-6, BR-11).
- AC-3 (manual) Given a field with a footnote, a message, then an error, when shown, then the text is below the control `supportSpacing` apart: the footnote leading and the message trailing in Foreground.secondary, the error trailing in Foreground.critical with a Border.critical border over the text field's native one and the system focus ring when focused (BR-6, BR-8, BR-10).
- AC-4 (manual) Given a hidden field, when the form is shown and Return pressed in the field before it, then the field isn't drawn and the focus skips it; given the focus in a field, when it becomes hidden, then it reports `false` and no field has the focus (BR-4, BR-5, BR-6).
- AC-5 (manual) Given a form, when it appears, then no field has the focus and no `onFocusChange` is called (BR-4).
- AC-7 (manual) Given the focus in the first field, when the user clicks or taps the third field, then the first field reports `false`, the third `true` and no other field reports anything (BR-4).
- AC-8 (manual) Given three text fields and a primary Action Button on macOS, when Return is pressed in each in turn, then the focus moves first → second → third, and in the third Return runs the button's action; on iOS and iPadOS the return keys read Next, Next, Done, and Done hides the keyboard with the third field reporting `false` (BR-4, BR-5).
- AC-9 (manual) Given VoiceOver, when an optional field with an error gets the focus, then the title, the qualifier and then the error are read; for a field with a footnote and no error, the title and then the footnote (BR-7).
- AC-10 (manual) Given a text field with a prompt, when empty, then the prompt shows; when typed into, then the field's value is exactly the typed text (BR-8).
- AC-11 (manual) Given a form inside a disabled container, when the user tries to type, then the text fields take no input (BR-8).
- AC-12 (manual) Given macOS text size 200 %, or iOS at the largest accessibility Dynamic Type size, when the form is shown, then labels, text and support text grow with it (theme-and-tokens BR-6).
- AC-13 (manual) Given each showcase page, when each Playground control changes, then the component and its snippet follow it, and Variants show light and dark (BR-14).
- AC-14 (manual) Given the finished showcase pages, when checked, then the four canvas pages show Implemented, `components.md` has the entries and architecture §2 lists the `Forms/` folders (BR-13).
- AC-15 (manual) Given VoiceOver and the focus in a field, when its support text becomes an error, then VoiceOver announces the copy `designSystem.fieldRow.error` with the title and the error, in Polish and English (BR-7, BR-11).

## Open questions
None.

## Changelog
- 2026-10-31 Drafted from the reminder-form design discussion (create-spec)
- 2026-10-31 Support text kinds footnote, message, error; an error draws the control's border critical; iOS row stacked, iPadOS like macOS; Q-3 closed (canvas pages Approved)
- 2026-10-31 Focus owned by the form and reported through `DK.FormField.onFocusChange`, `hasFocus` removed, no first focus, no focus to errors; native rounded-border text field with an error border overlay (Border.critical) and `fieldShowsError`; iOS Next and Done; error announcement ported; hidden-field and window focus cases; showcase Form controls (review-spec round 1)
