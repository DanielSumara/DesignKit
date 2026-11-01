# Money inputs
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: components/text-input, components/form-field-row

## Goal
The two atoms for an amount of money, paired in one Field Row: `DS.AmountInput`, a text field for a decimal amount, trailing, with the decimal keyboard on iPhone and iPad; and `DS.CurrencyPicker`, a native pop-up of display-ready `DK.CurrencyOption`s in the display style the owner picks.

## Scope
- In:
  - `DS.AmountInput`; `DK.CurrencyOption`; `DS.CurrencyPicker` with `DisplayStyle`
  - DesignSystem copy for the name-with-symbol style
  - Canvas pages "Atom · Amount Input", "Atom · Currency Picker"; showcase pages under Atoms; both added to the Field Row page's control picker (components/form-field-row BR-9); `components.md` entries
- Out:
  - Parsing, validating and formatting the amount with the currency's fraction digits: the ViewModel and UtilitiesKit
  - Currencies, their fraction digits and localized names: DataKit and the ViewModel that maps them
  - Search in a long currency list, recent or favorite currencies: a later spec when the list grows past the four currencies

## User stories
- US-1 As a user I want the decimal keyboard when I type an amount on iPhone and iPad so that I enter money quickly.
- US-2 As a user I want to choose the currency next to the amount so that I know what the number means.
- US-3 As a developer I want the currency shown as a symbol, an ISO code or a localized name, as my screen needs, without the design system knowing DataKit.

## Data
- `DS.AmountInput(text: Binding<String>, prompt: String? = nil)`
- `DK.CurrencyOption` (`Hashable`, `Sendable`; equal when `isoCode` is equal): isoCode: `String` — ISO 4217, three letters; symbol: `String` — display-ready ("zł"); name: `String` — localized by the ViewModel ("Polish złoty")
- `DS.CurrencyPicker(selection: Binding<DK.CurrencyOption>, options: [DK.CurrencyOption], displayStyle: DisplayStyle = .symbol)`; `DS.CurrencyPicker.DisplayStyle`: `symbol`, `isoCode`, `name`
- No component tokens: the text field's look and error look are Text Input's (components/text-input, form-fields BR-8); the pop-up is native

## Rules
- BR-1 Amount Input: the single-line Text Input field (components/text-input BR-1, BR-2) with its text and prompt always trailing, whatever the environment; it edits the text as typed, with no formatting or parsing.
- BR-2 Keyboard: iOS and iPadOS show the decimal pad; macOS the normal keyboard. On iOS and iPadOS the decimal pad's Done handling follows form-fields BR-5.
- BR-3 Error look: with `fieldShowsError` true the Amount Input draws the error look of form-fields BR-8; the Currency Picker draws none.
- BR-4 Currency Picker: the native menu-style picker (macOS pop-up button) sized to its content; the button and every menu item read the option in `displayStyle`: `symbol` the symbol, `isoCode` the ISO code, `name` the copy `designSystem.currencyPicker.nameWithSymbol` with name and symbol; the menu lists `options` in the given order with the selection checked.
- BR-5 Selection: choosing an item sets `selection` to that option; the picker never changes `options`.
- BR-6 Both controls take focus (form-fields BR-4), are disabled by the environment and use the theme's tint; the picker's own label is hidden, its accessibility label is the row's (components/form-field-row BR-5) and its value the option read in `displayStyle`.
- BR-7 Copy: key `designSystem.currencyPicker.nameWithSymbol` in DesignSystem's String Catalog, pl and en.
- BR-8 Previews: light and dark previews of Amount Input empty with prompt, with text, in error and disabled; of Currency Picker in each display style and disabled.
- BR-9 Showcase pages under Atoms: Amount Input (text, prompt, error, disabled), Currency Picker (EUR, GBP, PLN, USD sample options, display style, disabled, the selection's ISO code shown below); theme, amendment, appearance, text size, the live snippet; Variants: BR-8 cases light and dark. The Field Row page's control picker gains "Amount and currency": both in one row's control area, picker after the amount.
- BR-10 Lifecycle: approved only once both canvas pages are `Approved`; once the showcase pages are done, the canvas headers show Implemented and `components.md` gets the entries.

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.currencyPicker.nameWithSymbol | %1$@ (%2$@) | %1$@ (%2$@) |

## Acceptance criteria
- AC-1 (manual) Given an Amount Input with prompt "0.00", when empty, then the prompt shows trailing; when "1250,5" is typed, then the bound text is exactly "1250,5", trailing (BR-1).
- AC-2 (manual) Given iPhone and iPad, when an Amount Input gets the focus, then the decimal pad shows; on macOS no change of keyboard (BR-2).
- AC-3 (manual) Given an Amount Input in a row with an error, when shown and then focused, then the critical border and critical focus ring show; a Currency Picker in the same row shows no error look (BR-3).
- AC-4 (manual) Given a Currency Picker over EUR, GBP, PLN and USD with PLN selected, when shown in each display style, then the button reads "zł", "PLN" and "Polish złoty (zł)", and the open menu lists the four in the same style with PLN checked (BR-4).
- AC-5 (manual) Given the Polish locale and Polish names from the ViewModel, when the `name` style is shown, then the button reads "złoty polski (zł)" (BR-4, BR-7).
- AC-6 (manual) Given the picker on macOS with each style, when shown, then the button is as wide as its text and arrows, with no extra space (BR-4).
- AC-7 (manual) Given the menu open, when EUR is chosen, then the selection becomes EUR and the button reads EUR's text (BR-5).
- AC-8 (manual) Given a disabled container, when the user taps or clicks either control, then neither takes input and both draw disabled (BR-6).
- AC-9 (manual) Given VoiceOver, when the picker in a row titled "Currency" is focused, then "Currency" and the selected option are read (BR-6).
- AC-10 (manual) Given the Field Row page with "Amount and currency", when shown at regular width, then both controls trail in the control area, the amount first (BR-9).
- AC-11 (manual) Given the showcase pages, when each Playground control changes, then the controls and snippets follow it, Variants and the Xcode previews show the BR-8 cases light and dark; the finished pages leave the canvas headers Implemented and `components.md` with the entries (BR-8, BR-9, BR-10).

## Open questions
- Q-1 Should `DK.CurrencyOption` carry the fraction digits too, so that a later amount control can format by itself? Drafted without (canvas: the fraction digits stay with the ViewModel).

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Atom · Amount Input", "Atom · Currency Picker" (Approved 1 November 2026) (create-spec)
