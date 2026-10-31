# Form fields
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: components/base-atoms, foundations/theme-and-tokens, foundations/package-and-showcase

## Goal
The first form components of DesignSystem, enough for a form of text fields such as HomeBudgetApps reminders/configure-reminders/reminder-form: the field data object a ViewModel fills, a text field, the field row around any control (label, optional qualifier, footnote, message or error text), a section and the form holding the focus order. They live in a `Forms/` folder of DesignKit and DesignSystem, not in packages of their own (Q-1).

## Scope
- In:
  - `DK.FormField<Value: Equatable>`, `DK.SupportText`, in `Sources/DesignKit/Forms/`
  - In `Sources/DesignSystem/Forms/`: `DS.FormTextField` (atom), `DS.FieldRow` (molecule), `DS.FormSection` (organism), `DS.Form` (template)
  - Component configuration `fieldRow` in `DS.Theme.Components`
  - DesignSystem String Catalog key for the optional qualifier
  - Canvas pages "Atom · Form Text Field", "Molecule · Field Row", "Organism · Form Section", "Template · Form"; showcase pages; `components.md` entries once implemented
  - `docs/architecture.md` §2 Layout: the `Forms/` folders
- Out:
  - Amount, date, picker, toggle and other inputs, change cues and toggle buttons on a field: a later spec (components/form-inputs)
  - Validation rules and binding them to `DK.FormField` (HomeBudgetApps forms/validated-fields, UtilitiesKit validation/validators); parsing and formatting values (UtilitiesKit, each Core)
  - Presenting a form in a sheet (components/modal-sheet)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Pole formularza | Form field | One edited value with its label, help or error text and focus, filled by a ViewModel |
| Tekst pomocniczy | Support text | The line below a field's control: a footnote, a message or an error |
| Kwalifikator | Qualifier | The word after a field's label marking it optional |

## User stories
- US-1 As a user I want each field labelled, with its help or error right below it, so that I know what to enter and what to fix.
- US-2 As a user I want Return to take me to the next field so that I fill a form without reaching for the mouse or the screen.
- US-3 As a developer I want forms built from DesignSystem components over `DK.FormField` so that every form looks and moves focus the same way and a ViewModel drives errors and focus.

## Data
- `DK.FormField<Value: Equatable>` (`Equatable`; `Sendable` where `Value` is):
  - title: `String` — display-ready label, not empty
  - value: `Value` — the edited value as the control edits it (text for a text field)
  - isOptional: `Bool` — draws the qualifier of Copy after the title; default false
  - hasFocus: `Bool` — two-way with the focus (BR-4); default false
  - supportText: `DK.SupportText?` — default nil
  - isHidden: `Bool` — not drawn, not in the focus order; default false
- `DK.SupportText` (`Equatable`, `Sendable`): `footnote(String)` describes the item, `message(String)` describes an effect, `error(String)` names what to fix
- `DS.FormTextField(text: Binding<String>, prompt: String?)`; `DS.FieldRow(_ field: Binding<DK.FormField<Value>>, @ViewBuilder control: (Binding<Value>) -> Control)`; `DS.FormSection(_ title: String?, footer: String? = nil, @ViewBuilder content:)`; `DS.Form(@ViewBuilder content:)`
- Component tokens `fieldRow`: `supportTextColor(kind)` footnote and message → Foreground.secondary, error → Foreground.critical; `errorBorderColor` → Foreground.critical; `supportSpacing` → Spacing.xxSmall; support text Typography.footnote, section footer Typography.footnote (semantic, no tokens of their own)

## Rules
- BR-1 Port: each component starts from its FinanceTracker file (`Kits/DesignKit/Sources/DesignKit/DK+FormField.swift`, `DK+SupportText.swift`, `DesignKitUI/Molecules/DS+FieldRow.swift`, `DesignKitUI/Organisms/DS+FormSection.swift`, `DesignKitUI/Support/FormFocus.swift`), public names and signatures kept, with these deviations only: `qualifier: String?` becomes `isOptional` with DesignSystem's copy; no `changeCue`, `toggleButton` or read-only presentation initializer (components/form-inputs); `SupportText.footer` dropped, the section owns its footer; the focus order moves from `DS.FormSheet` into `DS.Form`.
- BR-2 Placement (Q-1): form types live in `Forms/` folders of the DesignKit and DesignSystem targets, in the flat `DK` and `DS` namespaces; the catalogue, canvas and showcase group them by atomic level like every other component; no type name equals a SwiftUI one.
- BR-3 Form: the native grouped form style on every platform, its sections in order; it scrolls on its own (components/modal-sheet BR-8) and keeps the focused field in view.
- BR-4 Focus: setting a field's `hasFocus` true moves the focus to its control and scrolls it into view; when the user moves the focus, the field gaining it gets `hasFocus` true and every other field of the form false; at most one field has it. When the form appears, the field with `hasFocus` true gets the focus, none when no field has it.
- BR-5 Return: in a text field, Return moves the focus to the next visible field of the form in order; in the last one it leaves the focus where it is and reaches the default action (base-atoms BR-5). Tab follows the same order natively.
- BR-6 Field row: the platform's labelled form row (label leading, control trailing on macOS and iPadOS; on iOS stacked: title with the qualifier, the control, the support text) with the title and, when `isOptional`, the qualifier; the support text below the control, `supportSpacing` apart, in `supportTextColor` of its kind, a footnote aligned leading, a message and an error trailing; a field with an error tells its control, which draws its border (and focus ring) in `errorBorderColor`; a hidden field draws nothing.
- BR-7 Accessibility: the control's label is the title (with the qualifier when optional); an error is read after the label as the control's hint; a footnote or message as its hint when there is no error.
- BR-8 Text field: the native single-line text field with an optional prompt; it edits the text as typed, no formatting or parsing (each Core's); disabled by the environment like any native control.
- BR-9 Section: the native form section with an optional title as header and an optional footer below it; nil or empty draws nothing.
- BR-10 Configuration: every token of Data is a property of `fieldRow` in `DS.Theme.Components`, read only through `@MDS(\.fieldRow)`.
- BR-11 Copy: key `designSystem.fieldRow.optional` in DesignSystem's String Catalog, pl and en (Copy).
- BR-12 Previews: each component file has light and dark previews; the form preview shows two sections, an optional field, a footnote, a message and an error.
- BR-13 Lifecycle: the spec is approved only once its four canvas pages are `Approved` (Q-2); once the showcase pages are done, the canvas headers show Implemented and `components.md` gets the entries; the slice adding the folders updates `docs/architecture.md` §2.
- BR-14 Showcase pages, under their atomic levels: Form Text Field (prompt, text), Field Row (title, isOptional, support text kind and text, hidden), Form Section (title, footer, rows), Form (two sections of three fields, a button setting `hasFocus` on the third, a field-with-focus readout); each with theme, amendment, appearance and text size, the live `DK.FormField(…)` snippet where the page shows one, Variants light and dark, Configuration with the `fieldRow` token chains.

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.fieldRow.optional | Opcjonalne | Optional |

## Acceptance criteria
- AC-1 (manual) Given a form of two sections on macOS, iPadOS and iOS, when shown, then it uses the grouped form style, sections in order with their titles and footers, and scrolls when taller than its space (BR-3, BR-9).
- AC-2 (manual) Given a field row with `isOptional` true, when shown, then its title is followed by the qualifier in Polish and English (BR-6, BR-11).
- AC-3 (manual) Given a field with a footnote, a message, then an error, when shown, then the text is below the control `supportSpacing` apart: the footnote leading and the message trailing in Foreground.secondary, the error trailing in Foreground.critical with the control's border in Foreground.critical (BR-6, BR-10).
- AC-4 (manual) Given a hidden field, when the form is shown and Return pressed in the field before it, then the field isn't drawn and the focus skips it (BR-5, BR-6).
- AC-5 (manual) Given a form whose second field has `hasFocus` true, when it appears, then that field has the focus; with none, no field has it (BR-4).
- AC-6 (manual) Given a form with the focus in the first field, when the ViewModel sets `hasFocus` on a field out of view, then that field gets the focus, is scrolled into view and the first field's `hasFocus` turns false (BR-3, BR-4).
- AC-7 (manual) Given the focus in the first field, when the user clicks or taps the third field, then the third field's `hasFocus` is true and every other false (BR-4).
- AC-8 (manual) Given three text fields, when Return is pressed in each in turn, then the focus moves first → second → third, and in the third Return runs the default action of the surrounding sheet (BR-5).
- AC-9 (manual) Given VoiceOver, when an optional field with an error gets the focus, then the title, the qualifier and then the error are read (BR-7).
- AC-10 (manual) Given a text field with a prompt, when empty, then the prompt shows; when typed into, then the field's value is exactly the typed text (BR-8).
- AC-11 (manual) Given a form inside a disabled container, when the user tries to type, then the text fields take no input (BR-8).
- AC-12 (manual) Given macOS text size 200 %, when the form is shown, then labels, text and support text grow with it (theme-and-tokens text size).
- AC-13 (manual) Given each showcase page, when each Playground control changes, then the component and its snippet follow it, and Variants show light and dark (BR-14).
- AC-14 (manual) Given the finished showcase pages, when checked, then the four canvas pages show Implemented, `components.md` has the entries and architecture §2 lists the `Forms/` folders (BR-13).

## Open questions
- Q-3 Closed: iOS stacks the row (title with qualifier, control, support text); iPadOS follows macOS (canvas page Field Row, BR-6)
- Q-4 Should the form move the focus to the first field with an error by itself when the confirm action finds errors? Proposed: no; the ViewModel sets `hasFocus` on it (HomeBudgetApps forms/validated-fields), BR-4 does the rest.

## Changelog
- 2026-10-31 Drafted from the reminder-form design discussion (create-spec)
- 2026-10-31 Support text kinds footnote, message, error; an error draws the control's border critical; iOS row stacked, iPadOS like macOS; Q-3 closed (canvas pages Approved)
