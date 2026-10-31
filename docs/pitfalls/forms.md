# DesignSystem form pitfalls
Check: Before changing focus or scrolling in `DS.Form`, or taking up components/form-focus-moves.

- Focus lives in each `DS.FieldRow` (`@FocusState Bool` on its control); the form holds no focus state. The control may carry its own `.focused($isFocused)` too: both follow the same field, and the control draws its focus look from its own state.
- iOS scrolls a focused field above the keyboard and macOS scrolls the first responder into view: don't add `scrollTo` for focus.
- A row's layout switch by size class keeps the control's identity (focus, keyboard, text) only through one `AnyLayout`.
- `.onDisappear` of a row also fires when it scrolls off screen, so it can't detect a field removed by the ViewModel.
- Don't write state or register callbacks from `body`; react to focus with `.onChange(of:)`.
- For form-level focus moves (components/form-focus-moves): environment set inside the `Group(sections:)` transform never reaches the rows (set it on the `Group`); `SwiftUI.Form` loads rows lazily, so focusing an off-screen row needs a `ScrollViewReader` scroll first and the focus set in a `Task`.
