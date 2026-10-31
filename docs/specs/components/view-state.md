# View state
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignSystem, DemoApps · Depends on: components/base-atoms, components/base-molecules, foundations/theme-and-tokens, foundations/package-and-showcase

## Goal
A DesignSystem organism rendering a `DK.ViewState<Content>`, the one way every screen or region shows its state (the first being the HomeBudgetApps Reminders root): idle draws nothing, loading shows the activity indicator with a label after a short delay, an edge case shows `DS.EdgeCaseView`, loaded shows the caller's content. Ported from FinanceTracker `DS.LoadableView`.

## Scope
- In:
  - `DS.ViewState` in two forms: with a content closure, and content-less over `DK.ViewState<Never>`
  - Component configuration `viewState` in `DS.Theme.Components`
  - Default loading copy in DesignSystem's String Catalog
  - Canvas page "Organism · View State" on the Design System canvas; showcase page "View State" under Organisms; `components.md` entry once implemented
- Out:
  - `DK.ViewState` itself, used as ported (foundations/package-and-showcase Data)
  - A placeholder or skeleton shown instead of the indicator while loading (FinanceTracker's `placeholder:` form): a later spec when a screen needs it
  - Determinate progress, refreshing while the content stays visible, pull to refresh: the owner's ViewModel and view
  - Progress inside a button: `DS.ActionButton` (components/base-atoms BR-4)
  - Edge case layout, icon, copy and actions: `DS.EdgeCaseView` (components/base-molecules BR-9) and the owner's ViewModel

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Stan widoku | View state | Which of idle, loading, loaded or edge case a screen or region is in |
| Opóźnienie wskaźnika | Indicator delay | Time in loading before the activity indicator appears, so quick loads never flash it |

## User stories
- US-1 As a user I want every screen to show loading, empty and failed states the same way so that I always know what the app is doing.
- US-2 As a user I want quick loads not to flash a spinner so that the app feels calm.
- US-3 As a VoiceOver user I want to hear what is loading so that I know the screen is working.
- US-4 As a developer I want one view taking my state and my content so that no screen re-implements its loading and edge-case looks.

## Data
- `DS.ViewState<Content, Loaded: View>(_ state: DK.ViewState<Content>, loadingLabel: Text? = nil, @ViewBuilder content: @escaping (Content) -> Loaded)`
- `DS.ViewState(_ state: DK.ViewState<Never>, loadingLabel: Text? = nil)`: content-less
- Component tokens `viewState`: `activityIndicatorDelay` (aliases the `duration` of Motion.quick, 150 ms), `labelSpacing` (Spacing.small); the loading label Typography.subheadline in Foreground.secondary (semantic, no tokens of their own)

## Rules
- BR-1 Port: starts from FinanceTracker `DS+LoadableView.swift` (`Kits/DesignKit/Sources/DesignKitUI/Organisms`), with these deviations only: named `DS.ViewState`, after the data it renders; no `placeholder:` form (Scope); the delay is the component token of Data instead of a literal; the loading label is drawn as text below the indicator (BR-5), since `DS.ActivityIndicator` keeps its label for accessibility only (components/base-atoms BR-2).
- BR-2 Area: in idle, loading and edge case the view takes all the space it is offered, so modifiers its owner attaches (`.task`, `.onAppear`) run in every state, idle included. In loaded it is the content as the closure returns it: no frame, padding, background or scroll view added.
- BR-3 Idle: nothing visible and nothing for accessibility.
- BR-4 Loading delay: entering loading shows the empty area; once the state has stayed loading for `activityIndicatorDelay`, the indicator and label of BR-5 appear, without animation. Leaving loading earlier never shows them; entering loading again restarts the delay. The delay is the same with Reduce Motion (as components/base-atoms BR-4b).
- BR-5 Loading look: centered in the area, a `DS.ActivityIndicator` at control size regular whatever the environment's control size, so macOS text size never turns it into the static large symbol (theme-and-tokens BR-8); below it, `labelSpacing` apart, the loading label in Typography.subheadline and Foreground.secondary, centered, wrapping, scaling with text size. Indicator and label are one accessibility element read with the label.
- BR-6 Loading label: the caller's `loadingLabel`; nil shows `designSystem.viewState.loading` (Copy).
- BR-7 Edge case: `DS.EdgeCaseView` for the state's edge case, with its layout, actions and keys (components/base-molecules BR-9).
- BR-8 Loaded: the content closure is called with the state's content on every update.
- BR-9 Changes: the view switches between cases at once, with no animation of its own; an owner's `withAnimation` around the state change applies. A change from loaded to loaded keeps the content's view identity, so its own state (scroll position, focus, text) survives new content; a change of case replaces the shown view.
- BR-10 Content-less form: draws idle, loading and edge case as above; loaded cannot occur.
- BR-11 Configuration: every token of Data is a property of `viewState` in `DS.Theme.Components`, read only through `@MDS(\.viewState)`; every built-in theme defines it (a missing one fails to compile); `activityIndicatorDelay` aliases the `duration` of Motion.quick as `actionButton.activityIndicatorDelay` does (components/base-atoms BR-4b). No token joins the scaling list.
- BR-12 Copy: key `designSystem.viewState.loading` in DesignSystem's String Catalog, pl and en (Copy).
- BR-13 Previews: the component file has light and dark previews of idle, loading after the delay, loaded and an edge case with one action, and of the content-less form in loading.
- BR-14 Showcase page "View State" under Organisms: Playground with controls for the state (idle, loading, loaded, edge case), the loading label (default or custom text), the edge case (symbol, title, message, zero to two actions) and a replay of loading followed by loaded after 0.1 s or 1 s, plus theme, amendment, appearance and text size, with the live `DS.ViewState(…)` snippet; Variants: the BR-13 cases light and dark, and idle with a counter of its `.task` runs; Configuration: the `viewState` token chains.
- BR-15 Lifecycle: the spec is approved only once the canvas page "Organism · View State" is `Approved`; once the showcase page is done, the canvas header shows Implemented and `components.md` gets the entry.

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.viewState.loading | Wczytywanie | Loading |

## Acceptance criteria
- AC-1 (manual) Given the Variants idle sample, when the page appears, then nothing is drawn in its area and its `.task` counter reads 1 (BR-2, BR-3).
- AC-2 (manual) Given the Playground state loading, when it is chosen, then the area stays empty for 150 ms, then the spinning native indicator and the label below it appear centered, without animation (BR-4, BR-5).
- AC-3 (manual) Given the replay with loaded after 0.1 s, when it runs, then the indicator never appears and the content shows; with loaded after 1 s, the indicator appears after 150 ms and gives way to the content (BR-4, BR-8).
- AC-4 (manual) Given Reduce Motion on, when the 1 s replay runs, then the indicator still appears after 150 ms (BR-4).
- AC-5 (manual) Given no custom label, when loading shows in Polish and in English, then the label reads the Copy table's text; given a custom label, then that text shows (BR-6, BR-12).
- AC-6 (manual) Given VoiceOver in Polish and in English, when the loading look is focused, then the label is read once as one element; in idle nothing is focusable (BR-3, BR-5).
- AC-7 (manual) Given macOS text size 200 % and iPhone at the largest accessibility text size, when loading shows, then the indicator is still the native spinner and the label grows, wraps and stays centered below it (BR-5).
- AC-8 (manual) Given the state edge case with Try Again (primary), when shown, then it looks like the same edge case on the Edge Case page, Try Again runs its action and Return triggers it on macOS (BR-7).
- AC-9 (manual) Given the state loaded with sample content, when shown, then the content is laid out as it is without the view: no added padding, background or frame (BR-2, BR-8).
- AC-10 (manual) Given loaded content with a text field holding typed text, when the state changes to loaded with new content, then the typed text and the focus remain; when the state changes to loading, then the content is replaced by the loading look (BR-9).
- AC-11 (manual) Given the content-less form, when its state is idle, loading or an edge case, then it draws as AC-1, AC-2 and AC-8 do (BR-10).
- AC-12 (manual) Given the showcase page, when each Playground control changes, then the view and the `DS.ViewState(…)` snippet follow it, Variants show every BR-13 case light and dark, Configuration and the Component tokens page show `viewState.activityIndicatorDelay` → Motion.quick and `labelSpacing` → Spacing.small with their primitives; in Xcode the component file's previews show the BR-13 cases light and dark (BR-11, BR-13, BR-14).
- AC-13 (manual) Given the finished showcase page, when checked, then the canvas page shows Implemented and `components.md` has the entry (BR-15).

## Open questions
- Q-1 Should the default label carry an ellipsis ("Wczytywanie…", "Loading…"), as macOS progress labels usually do? FinanceTracker has none; the Copy table follows it until answered.

## Changelog
- 2026-10-31 Drafted from the placeholder, ported from FinanceTracker `DS.LoadableView` (create-spec)
