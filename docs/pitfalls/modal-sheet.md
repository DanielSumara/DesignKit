# DesignSystem modal sheet pitfalls
Check: Before changing the sizing of `DS.ModalSheet` or taking up its manual ACs (AC-10, AC-11).

## macOS sizing outcome (BR-7, Q-3)
- Tried: `.frame(width: standardWidth | wideWidth)` + `.frame(maxHeight: maxHeight)` + `.presentationSizing(.fitted)` on the sheet's root view. Widths and `maxHeight` come from `@MDS(\.modalSheet)`, so they scale with the text size through the token factor.
- Chosen: exactly that; no window probe or measurement. `.fitted` sizes the sheet to the root view's ideal size, the fixed-width frame pins the width, the max-height frame caps the height.
- Why: it is the declarative route Q-3 asks for first and needs no `NSWindow` access, which DesignSystem may not import.
- Unverified (built and linted, never presented; no UI run in the slice): that the sheet takes the content's height for a few rows, and stops at `maxHeight` with a scrolling `List`/`ScrollView` content. A `ScrollView` reports its content as ideal height, so it should grow then scroll; a macOS `List` may report a small default ideal height and then the sheet would be too short. Check by hand with AC-10 and AC-11 in the showcase page (S4).
- Fallback if AC-10 fails: measure the content's height with `onGeometryChange`, keep it in `@State` and set `.frame(height: min(measured + header + button row, maxHeight))`. The content must report its natural height (not inside a scroll view of the sheet, BR-8), so a self-scrolling content needs a measured or ideal height from its own side.

## iOS and iPadOS
- `.presentationSizing(.form)` for `standard`, `.page` for `wide`; the two members have different generic types, so choose them in a `switch` inside a `@ViewBuilder`, not with a ternary.
- iPhone and compact width ignore the sizing and show the full-height sheet; nothing else is set.
