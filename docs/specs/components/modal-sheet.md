# Modal sheet
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: components/base-atoms, foundations/theme-and-tokens, foundations/package-and-showcase

## Goal
A DesignSystem template for the content of a modal sheet, reused by every feature that asks for input in a sheet (the first being the HomeBudgetApps reminder form): a title, an optional subtitle, Cancel and an optional confirm action placed as each platform places them, a content slot, and a discard confirmation the owner's ViewModel switches on while there are unsaved changes. Named after the HIG term "sheet" (Q-1).

## Scope
- In:
  - `DK.ModalSheet`: title, subtitle, cancel and confirm actions, `confirmsDiscard`
  - `DS.ModalSheet<Content: View>(_ data: DK.ModalSheet, width: Width = .standard, @ViewBuilder content:)`, Template level
  - Component configuration `modalSheet` in `DS.Theme.Components`, its text-bound sizes on the scaling list
  - Size primitives `size480`, `size560`, `size640`
  - Discard confirmation copy in DesignSystem's String Catalog
  - Canvas page "Template · Modal Sheet" on the Design System canvas; showcase page under a new Templates sidebar section; `components.md` entry once implemented
- Out:
  - Presenting and dismissing the sheet: the owner's presentation (`.sheet(item:)`)
  - Form layout, fields, focus (components/form-fields); validation (HomeBudgetApps forms/validated-fields)
  - Destructive and role-less actions in the sheet (Q-2), detents, sheets over sheets, navigation pushes inside the sheet, toolbars beyond the two actions, inspector and popover presentations
  - A discard confirmation after a swipe down (Q-6)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Arkusz modalny | Modal sheet | A view presented over its window or screen that takes input until it is cancelled or confirmed |
| Potwierdzenie odrzucenia | Discard confirmation | The dialog asking whether to close a sheet with unsaved changes |

## User stories
- US-1 As a user I want every sheet to look and close the same way on my device so that I know how to finish or leave it.
- US-2 As a user I want to be asked before a sheet with my unsaved changes closes so that I don't lose them by accident.
- US-3 As a developer I want one sheet template taking my content so that no feature re-implements the header, the buttons or the discard confirmation.

## Data
- `DK.ModalSheet` (`Sendable`, `Equatable`):
  - title: `String` — display-ready, not empty
  - subtitle: `String?` — nil or empty draws nothing
  - cancel: `DK.ActionButton` — drawn with role `cancel` whatever its role; runs on the cancel path (BR-4)
  - confirm: `DK.ActionButton?` — drawn with role `primary` whatever its role; nil shows Cancel only
  - confirmsDiscard: `Bool` — set by the owner's ViewModel while the sheet holds unsaved changes (BR-5)
- `DS.ModalSheet.Width`: `standard`, `wide` — a configuration of the call site, not data
- Component tokens `modalSheet`: `standardWidth` (size480), `wideWidth` (size640), `maxHeight` (size560), all text-bound on macOS; `headerSpacing` (Spacing.xxSmall), `contentSpacing` (Spacing.medium), `padding` (Spacing.large); title Typography.headline, subtitle Typography.subheadline in Foreground.secondary (semantic, no tokens of their own)

## Rules
- BR-1 Port: the header, action placement and sizing start from FinanceTracker `DS.FormSheet` (`Kits/DesignKit/Sources/DesignKitUI/Templates/DS+FormSheet.swift`), with these deviations only: no table styles, status line or footer; the content slot knows nothing of what it holds; actions are `DK.ActionButton`s; window sizing through component tokens instead of window probes where the platform allows (Q-3).
- BR-2 Header: iOS and iPadOS wrap the content in the template's own `NavigationStack` and show the title inline in the navigation bar and the subtitle as its navigation subtitle. macOS sheets have no title bar, so the title and subtitle are drawn above the content, `headerSpacing` apart, the title a header for accessibility; the header is inset by `padding` on its top, leading and trailing edges and sits `contentSpacing` above the content. No subtitle leaves no gap.
- BR-3 Actions: drawn with `DS.ActionButton` (base-atoms BR-3, BR-4, BR-5 for look, loading and keys); cancel at the platform's cancellation placement, confirm at its confirmation placement: iOS and iPadOS leading and trailing in the navigation bar, macOS in a button row at the bottom trailing edge, Cancel before the confirm action, the row inset by `padding` on its bottom, leading and trailing edges and `contentSpacing` below the content. Return runs the confirm action and Esc takes the cancel path of BR-4, on macOS and on iPadOS with a hardware keyboard.
- BR-4 Closing: the sheet never closes itself; the owner closes it by clearing its route. Cancel and Esc are the cancel path: with `confirmsDiscard` false it runs the cancel action at once; with true it shows the discard confirmation (BR-5) and the sheet stays. On iOS and iPadOS a swipe down while `confirmsDiscard` is true, or while BR-6 ignores the cancel path, springs back and shows nothing; otherwise the system closes the sheet through the owner's presentation, the owner sees its route cleared, and the cancel action doesn't run (Q-6).
- BR-5 Discard confirmation: a confirmation dialog with the title and message of Copy and two actions: Discard Changes (destructive) runs the cancel action; Keep Editing (cancel) closes the dialog and keeps the sheet and its content as they were. iOS shows it as an action sheet, iPadOS as a popover from Cancel, where the system draws no Keep Editing and tapping outside the popover keeps editing, macOS as an alert sheet over the sheet. The ViewModel owns when it applies; the sheet owns its copy (Q-5).
- BR-6 Busy and disabled: the sheet wraps the confirm action to know when it runs; from the moment it starts until it returns, and while the confirm action's state is `loading`, Cancel shows disabled, the cancel path is ignored and the content is disabled; the confirm button's loading look keeps base-atoms BR-4's delay. When it ends, all are as before. While the cancel action's state is `disabled` the cancel path is ignored too.
- BR-7 Size: iPhone shows a full-height sheet. iPadOS uses system sizing: `standard` the form size, `wide` the page size, full height in compact width (Q-7). macOS sizes the sheet to `standardWidth` or `wideWidth` and to the content's height, stopping at `maxHeight`, where the content scrolls (Q-3). The widths and `maxHeight` scale with text size on macOS (theme-and-tokens text size); iOS and iPadOS scale text with Dynamic Type.
- BR-8 Content: given the sheet's width, edge to edge, below the header and above the macOS button row; the sheet adds no scroll view of its own, so a scrolling content (a form, components/form-fields) scrolls itself and a short one is not stretched.
- BR-9 Configuration: every token of Data is a property of `modalSheet` in `DS.Theme.Components`, read only through `@MDS(\.modalSheet)`; `standardWidth`, `wideWidth` and `maxHeight` join the scaling list.
- BR-10 Copy: keys `designSystem.modalSheet.discard.{title, message, discard, keepEditing}` in DesignSystem's String Catalog, pl and en (Copy).
- BR-11 Previews: the component file has light and dark previews of a sheet with and without subtitle, with and without confirm action, and one with `confirmsDiscard` true.
- BR-12 Lifecycle: the spec is approved only once the canvas page "Template · Modal Sheet" is `Approved` (Q-4); once the showcase page is done, the canvas header shows Implemented and `components.md` gets the entry.
- BR-13 Showcase page "Modal Sheet" under a new Templates sidebar section: Playground with a button presenting the sheet and controls for title, subtitle, confirm present, each action's state, `confirmsDiscard`, width, a confirm action lasting 2 s and sample content of a few rows or a long list, plus theme, amendment, appearance and text size, with the live `DK.ModalSheet(…)` snippet; Variants: the BR-11 cases, light and dark; Configuration: the `modalSheet` token chains.

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.modalSheet.discard.title | Odrzucić zmiany? | Discard changes? |
| designSystem.modalSheet.discard.message | Wprowadzone zmiany nie zostaną zapisane. | Your changes won't be saved. |
| designSystem.modalSheet.discard.discard | Odrzuć zmiany | Discard Changes |
| designSystem.modalSheet.discard.keepEditing | Kontynuuj edycję | Keep Editing |

## Acceptance criteria
- AC-1 (manual) Given a sheet with title, subtitle and both actions on iPhone and iPad, when presented, then the title is inline in the navigation bar with the subtitle below it, Cancel leading, the confirm action trailing; on iPad with a hardware keyboard Return runs the confirm action and Esc runs the cancel action (BR-2, BR-3).
- AC-2 (manual) Given the same sheet on macOS, when presented, then title and subtitle are above the content, Cancel and the confirm action at the bottom trailing edge, header and button row inset by `padding` and `contentSpacing` from the content, Return runs the confirm action and Esc runs the cancel action (BR-2, BR-3, BR-4).
- AC-3 (manual) Given a sheet without subtitle, or without confirm action, when presented, then no subtitle space, or only Cancel, is drawn; Return does nothing on macOS (BR-2, BR-3).
- AC-4 (manual) Given `confirmsDiscard` false, when Cancel is clicked or Esc pressed, then the cancel action runs once without a dialog; when, on iPhone and iPad, the sheet is swiped down, then it closes and the cancel action doesn't run (BR-4).
- AC-5 (manual) Given `confirmsDiscard` true, when Cancel is clicked or Esc pressed, then the discard confirmation shows with the Copy texts, the sheet stays open and the cancel action doesn't run (BR-4, BR-5).
- AC-6 (manual) Given `confirmsDiscard` true on iPhone and iPad, when the sheet is swiped down, then it springs back, no dialog shows and the cancel action doesn't run (BR-4).
- AC-7 (manual) Given the discard confirmation, when Keep Editing is chosen (on iPad, a tap outside the popover), then the dialog closes and the content is unchanged; when Discard Changes is chosen, then the cancel action runs once (BR-5).
- AC-8 (manual) Given a confirm action lasting 2 s, when it starts, then at once Cancel shows disabled, Esc and swipe do nothing and the content takes no input, and after the loading delay the confirm action shows loading; afterwards all respond again; the same holds while the confirm action's state is `loading` (BR-6).
- AC-9 (manual) Given a cancel action with state `disabled`, when Esc is pressed or the sheet swiped down, then nothing happens (BR-4, BR-6).
- AC-10 (manual) Given macOS with content of a few rows, when presented at `standard` and `wide`, then the sheet takes the width of each and the content's height; with a long list it stops at `maxHeight` and the list scrolls; on iPad `standard` and `wide` take the system form and page sizes (BR-7, BR-8).
- AC-11 (manual) Given macOS text size 200 %, when the sheet is presented, then its width and maximum height grow with the text size (BR-7, BR-9).
- AC-12 (manual) Given Polish and English, when the discard confirmation shows, then its texts are the Copy table's (BR-10).
- AC-13 (manual) Given VoiceOver on macOS, when the sheet appears, then the title is read as a header, followed by the subtitle (BR-2).
- AC-14 (manual) Given the showcase page, when each Playground control changes, then the sheet and the `DK.ModalSheet(…)` snippet follow it, and Variants show every BR-11 case light and dark (BR-13).
- AC-15 (manual) Given the finished showcase page, when checked, then the canvas page shows Implemented and `components.md` has the entry (BR-12).

## Changelog
- 2026-10-31 Drafted from the reminder-form design discussion (create-spec)
- 2026-10-31 Swipe down without discard dialog, iPad system sizing, busy tracking by the sheet, size primitives, macOS insets, own navigation stack, iPad popover without Keep Editing, forced roles; Q-2, Q-3, Q-5, Q-6, Q-7 answered (review-spec round 1)
