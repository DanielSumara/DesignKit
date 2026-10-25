# Base atoms
Status: Approved · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: foundations/theme-and-tokens, foundations/foundations-pages, foundations/package-and-showcase

Split from base-components (Q-6); ids are kept from it, so gaps are the rules and criteria of components/base-molecules. Ids of another spec are cited with its name (`base-atoms BR-10`, `base-molecules BR-10`); a bare id is this spec's.

## Goal
The first three DesignSystem atoms, all `Approved` on the Design System canvas, ported from FinanceTracker (`Kits/DesignKit/Sources/DesignKitUI/Atoms`) and brought to their canvas look: Activity Indicator, Action Button, Status Icon. Each gets its component tokens, light and dark previews and a showcase page. They are the first component configurations, so they also settle what theme-and-tokens left for the first component spec and which values become component tokens (Q-7).

## Scope
- In:
  - `DK.Status` (new); `DK.ActionButton` used as ported (package-and-showcase BR-3)
  - `DS.ActivityIndicator`, `DS.ActionButton` with `.actionButtonStyle(_:)`, `DS.StatusIcon`
  - Component configurations `activityIndicator`, `actionButton`, `statusIcon` in `DS.Theme.Components`, their text-bound sizes on the scaling list, primitives `size48` and `size64`
  - Three showcase pages; canvas status Implemented and `components.md` entries once implemented
- Out:
  - Inline Alert, Edge Case, the DesignSystem String Catalog, the `DK.AccentTint` mapping and the sample amendment's component override (components/base-molecules)
  - `DK.Tone` mapping and `foregroundStyle(tone:)` (no component here uses them); `DK.Alert` and its alert modifier
  - Loadable view, progress bar, field errors, badges; platform design-system targets (nothing here differs per platform beyond native controls)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Wskaźnik aktywności | Activity indicator | Shows that work of unknown length is in progress |
| Przycisk akcji | Action button | Runs one asynchronous action; its role sets look and key |
| Rola | Role | primary, destructive, cancel or none: the action's meaning |
| Styl przycisku | Button style | An environment override of the role's look for a container |
| Ikona statusu | Status icon | The symbol of a status in its Foreground color |
| Status | Status | info, success, warning, error, in rising severity; not `DK.Tone`, which has no order and a neutral case (Q-8) |

## User stories
- US-1 As an app developer I want one activity indicator sized by the environment's control size so that every loading state looks the same.
- US-2 As an app developer I want an action button rendering `DK.ActionButton` so that a ViewModel builds actions as data and their look, keys and loading follow the role.
- US-3 As an app developer I want a container-wide button style override so that a toolbar or alert restyles its buttons without changing the data.
- US-6 As a VoiceOver user I want indicators, buttons and status icons labelled so that I hear what is loading, what a button does and which status a labelled icon shows.
- US-7 As a DesignKit developer I want a showcase page per component so that every variant, configuration and token chain can be checked without reading code.

## Screens & navigation
### Activity Indicator (atom, `DS.ActivityIndicator`)
- `DS.ActivityIndicator(label: Text)`; size from the environment's `controlSize`, no size parameter; no progress value.
- mini, small, regular: the native indeterminate spinner at the platform's system size. large, extraLarge: the SF Symbol `progress.indicator`, static, in Foreground.brand, a square of `largePlaceholderSize` or `extraLargePlaceholderSize`.
- VoiceOver reads the label; nothing is drawn for it.

### Action Button (atom, `DS.ActionButton`)
- `DS.ActionButton(data: DK.ActionButton)`; label `title` in Typography body semibold; `.actionButtonStyle(_:)` on any container sets `DS.ActionButton.Style` (primary, secondary, tertiary, success, destructive) for the buttons inside.
- States: normal; disabled (data `.disabled`): the native disabled look, no taps; loading (data `.loading`, or an action running past the delay): label hidden keeping its width, a small Activity Indicator labelled with the title in its place, in the label's color (OnBackground.* of the look, BR-3), taps ignored.
- HIG: native bordered, bordered prominent and borderless buttons on every platform; Return and Esc as the default and cancel keys (Mac, and iPhone and iPad with a hardware keyboard).

### Status Icon (atom, `DS.StatusIcon`)
- `DS.StatusIcon(_ status: DK.Status, size: CGFloat, label: Text? = nil)`; the owner passes its own size token value.
- Symbols: info `info.circle.fill`, success `checkmark.circle.fill`, warning `exclamationmark.triangle.fill`, error `xmark.octagon.fill`; color `statusIcon.color(status)`.
- Hidden from VoiceOver unless the owner gives a label, which it then reads.

### Showcase pages (DemoApps)
- Sidebar Atoms: Action Button, Activity Indicator, Status Icon; one file and one catalog entry each (package-and-showcase BR-8).
- Playground (architecture §7): a control per configuration-relevant input and per data field, the session's Theme, Amendment, Appearance and Text size, and the live `DK.{Name}(…)` or `DS.{Name}(…)` snippet.
  - Activity Indicator: control size (five), label.
  - Action Button: title, role (four, none included), state (three), style override (none and five), action duration (instant, 1 s, 3 s).
  - Status Icon: status (four), label on or off.
- Variants, light and dark (the loading look shows its indicator in the label's color): every control size; every role × state and every style override × role; every status.
- Configuration: each component token with its chain (component → semantic → primitive), from the inventory.

## Data
- `DK.Status`: enum `info`, `success`, `warning`, `error`; `Comparable` by severity in that order (error most severe), `CaseIterable`, `Sendable`. No conversion to or from `DK.Tone` (Q-8).
- `DS.ActionButton.Style`: enum `primary`, `secondary`, `tertiary`, `success`, `destructive`, `CaseIterable`, `Sendable`; environment value optional, `nil` by default.
- Component tokens (standard theme):

| Configuration | Token | Alias | Scales |
|---|---|---|---|
| activityIndicator | largePlaceholderSize | size48 | yes |
| activityIndicator | extraLargePlaceholderSize | size64 | yes |
| actionButton | activityIndicatorDelay | duration of Motion.quick | — |
| statusIcon | color(info, success, warning, error) | Foreground.info, .success, .warning, .critical | — |

## Rules
- BR-1 Port: each component starts from its FinanceTracker file (`DS+ActivityIndicator.swift`, `DS+ActionButton.swift`), public names and signatures kept, with these deviations only: `DK.CallToAction` is `DK.ActionButton` (already ported); the component tokens of Data replace FinanceTracker's literal configuration values; `DS.StatusIcon` and `DK.Status` are new.
- BR-2 Activity Indicator: mini, small and regular draw the native spinner; on iPhone and iPad, sizes the platform doesn't distinguish render at its nearest system size. large and extraLarge draw `progress.indicator` without animation at their tokens, in Foreground.brand. The label is the accessibility label in every size.
- BR-3 Action Button look, from role and style override (override `nil` = none):

| Role | No override | primary or success | secondary | tertiary | destructive |
|---|---|---|---|---|---|
| primary | prominent, Background.brand, OnBackground.brand label | prominent, Background.brand / .success, OnBackground.brand / .success label | bordered | borderless, Foreground.brand label | prominent, Background.critical, OnBackground.critical label |
| destructive | bordered, Foreground.critical label | bordered, Foreground.critical label | bordered | borderless, Foreground.brand label | bordered, Foreground.critical label |
| cancel, none | bordered | prominent, Background.brand / .success, OnBackground.brand / .success label | bordered | borderless, Foreground.brand label | bordered, Foreground.critical label |

  Bordered buttons keep the native neutral look, never the scene tint. In an inactive Mac window prominent labels take the system's inactive look. Disabled overrides every look with the native disabled one.
- BR-4 Action Button behavior: a tap or its key runs `action` on the main actor; while it runs further taps and key presses are ignored; if it runs longer than `activityIndicatorDelay` the loading look appears until it returns, both transitions animated with Motion.quick, and instant with Reduce Motion (theme-and-tokens BR-11); a quicker action never shows the indicator. A running action is never cancelled by the button disappearing or receiving new data. Data state `.loading` shows the loading look at once and ignores taps and keys; `.disabled` ignores them.
- BR-4a Loading indicator color: the loading indicator takes the color of the label it replaces, the look's OnBackground.*, Foreground.* or native neutral label color (BR-3), also under style overrides; in an inactive window it follows the label's inactive look.
- BR-4b activityIndicatorDelay aliases only the `duration` of the semantic Motion.quick (a `duration` alias of a semantic token, a case theme-and-tokens BR-1 does not list), so the delay stays 150 ms with Reduce Motion.
- BR-5 Action Button keys and roles: primary is the default action (Return), cancel the cancel action (Esc), destructive and none have no key; destructive and cancel set the matching system button role. An owner shows at most one primary and one cancel button per window or sheet; with more, which one answers the key is the system's choice. VoiceOver reads the title.
- BR-6 Status Icon: color `statusIcon.color(status)`, size the owner's already scaled value (no token of its own, no scaling of its own), hidden from accessibility without a label, read with one.
- BR-10 Configuration: `activityIndicatorDelay` aliases the `duration` of the semantic Motion.quick token (BR-4b); every token of Data is a property of its component configuration in `DS.Theme.Components`, read only through `@MDS(\.{component})`; every built-in theme defines it (a missing one fails to compile); the two tokens marked "scales" join the text-bound scaling list (theme-and-tokens BR-7); `size48` and `size64` join the `size` primitives in order.
- BR-13 Previews: each component file has a light and a dark preview showing its variants; the Activity Indicator previews render without `.theme(_:)` (theme-and-tokens BR-9 default).
- BR-14 Lifecycle: once a component's showcase page is done, its canvas page header shows Implemented and `components.md` (skill `design-system`) gets its entry; the canvas Foundations primitives board lists `size48` and `size64`. Checked by AC-34.
- BR-16 Component token scope (Q-7): a component token exists only for a value that varies by the component's variant (status, role, size) or belongs to the component alone (its own sizes, delays, spacing and radii); every other value, such as a label color or a font, is read from its semantic token through `mds`. Adding a component token later is an additive change.

## Copy
None: every label comes from the owner (`label`, `title`).

## Acceptance criteria
- AC-1 (manual) Given the Activity Indicator page, when each control size is chosen, then mini, small and regular show the spinning native indicator and large and extraLarge the static `progress.indicator` symbol at 48 and 64 pt in the brand color, in light and dark.
- AC-2 (manual) Given the Mac showcase at text size 200 %, when the Activity Indicator shows large, then the symbol is 96 pt; on iPhone at the largest accessibility text size it is larger than 48 pt, growing with body (BR-10, theme-and-tokens BR-7).
- AC-3 (manual) Given VoiceOver on an Activity Indicator labelled "Loading", when it is focused, then VoiceOver reads "Loading" in every size.
- AC-4 (manual) Given the Action Button Variants, when each role × state and each override × role is shown, then every look matches BR-3 in light and dark, including primary under destructive as prominent critical and destructive under primary and success staying bordered critical.
- AC-5 (manual) Given an Action Button with a 3 s action, when it is tapped, then the label gives way to a small indicator after 150 ms, further taps and Return do nothing, and the label returns when the action ends; given an instant action, then no indicator appears; with Reduce Motion on, the label and indicator swap without animation (BR-4, theme-and-tokens BR-11).
- AC-6 (manual) Given an Action Button with state `.loading`, when it is shown, then the indicator shows at once and taps do nothing; with `.disabled`, then it has the native disabled look and taps do nothing.
- AC-7 (manual) Given a primary and a cancel Action Button on the Mac, when Return and then Esc are pressed, then each runs its own action; on iPad with a hardware keyboard likewise.
- AC-8 (manual) Given a primary Action Button in a Mac window that loses focus, when the window is inactive, then its label takes the system's inactive look.
- AC-23 (manual) Given a bordered Action Button under a brand scene tint, when it is shown, then it stays neutral.
- AC-24 (manual) Given prominent and bordered Action Buttons in the loading look, including under style overrides, when shown, then each indicator has the color of the label it replaces, including the native neutral bordered looks and an inactive window (BR-4a).
- AC-25 (manual) Given a Status Icon of size 20 at Mac text size 200 %, when shown, then it stays 20 pt; the owner's passing a scaled size is what grows it (BR-6).
- AC-26 (manual) Given Reduce Motion on and an Action Button with a 3 s action, when tapped, then the indicator appears after 150 ms, as without Reduce Motion (BR-4b).
- AC-9 (manual) Given VoiceOver on an Action Button titled "Try again", when it is loading, then VoiceOver still reads "Try again".
- AC-10 (manual) Given the Status Icon page, when each status is shown, then it draws its symbol of the Status Icon section in Foreground.info, .success, .warning and .critical, light and dark; with the label off VoiceOver skips it, with it on VoiceOver reads it.
- AC-17 (manual) Given each of the three pages, when Theme, Amendment, Appearance and Text size are changed, then the Playground follows them and the snippet shows the current data; Variants show light and dark.
- AC-18 (manual) Given Xcode previews of each component file, when they render, then a light and a dark preview show; the Activity Indicator previews render the standard theme without `.theme(_:)`.
- AC-19 Given a theme missing any token of Data, when the package builds, then it fails to compile (BR-10); checked once in the slice that adds the configurations.
- AC-20 (manual) Given the Component tokens page, when Theme standard and Amendment none are chosen, then every token of Data shows with its chain (foundations-pages BR-6).
- AC-34 (manual) Given a finished showcase page, when checked, then its canvas header shows Implemented and `components.md` has its entry; the canvas Foundations primitives board lists `size48` and `size64` (BR-14).

## Open questions
- None.
