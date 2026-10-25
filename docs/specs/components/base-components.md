# Base components
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: foundations/theme-and-tokens, foundations/foundations-pages, foundations/package-and-showcase

## Goal
The first five DesignSystem components, all `Approved` on the Design System canvas, ported from FinanceTracker (`Kits/DesignKit/Sources/DesignKitUI/Atoms`, `Molecules`) and brought to their canvas look: Activity Indicator, Action Button, Status Icon (atoms), Inline Alert and Edge Case (molecules). Each gets its component tokens, light and dark previews and a showcase page. They are the first component configurations, so they also settle what theme-and-tokens left for the first component spec.

## Scope
- In:
  - `DK.Status` and `DK.InlineAlert` (new); `DK.ActionButton`, `DK.EdgeCase`, `DK.Icon`, `DK.AccentTint` used as ported (package-and-showcase BR-3)
  - `DS.ActivityIndicator`, `DS.ActionButton` with `.actionButtonStyle(_:)`, `DS.StatusIcon`, `DS.InlineAlert`, `DS.EdgeCaseView`
  - Component configurations `activityIndicator`, `actionButton`, `statusIcon`, `inlineAlert`, `edgeCase` in `DS.Theme.Components`, their text-bound sizes on the scaling list, primitives `size48` and `size64`
  - The `DK.AccentTint` color mapping (theme-and-tokens Scope Out); the sample amendment's component override (theme-and-tokens BR-10)
  - DesignSystem's String Catalog and its first keys
  - Five showcase pages; canvas status Implemented and `components.md` entries once implemented
- Out:
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
| Status | Status | info, success, warning, error, in rising severity |
| Alert w treści | Inline alert | A static note in the content gathering one place's notices |
| Komunikat | Notice | One title and message of an inline alert, with its status |
| Przypadek brzegowy | Edge case | Fills a screen or region with nothing to show: empty, failed, not allowed |
| Monogram | Monogram | Initials on a tinted circle |

## User stories
- US-1 As an app developer I want one activity indicator sized by the environment's control size so that every loading state looks the same.
- US-2 As an app developer I want an action button rendering `DK.ActionButton` so that a ViewModel builds actions as data and their look, keys and loading follow the role.
- US-3 As an app developer I want a container-wide button style override so that a toolbar or alert restyles its buttons without changing the data.
- US-4 As an app developer I want an inline alert gathering several notices in one tone so that a screen explains itself without interrupting the user.
- US-5 As an app developer I want an edge case view for empty, failed and not-allowed states so that every such state looks native and offers its next step.
- US-6 As a VoiceOver user I want indicators, buttons and alerts labelled so that I hear what is loading, what a button does and how severe a note is.
- US-7 As a DesignKit developer I want a showcase page per component so that every variant, configuration and token chain can be checked without reading code.

## Screens & navigation
### Activity Indicator (atom, `DS.ActivityIndicator`)
- `DS.ActivityIndicator(label: Text)`; size from the environment's `controlSize`, no size parameter; no progress value.
- mini, small, regular: the native indeterminate spinner at the platform's system size. large, extraLarge: the SF Symbol `progress.indicator`, static, in Foreground.brand, a square of `largePlaceholderSize` or `extraLargePlaceholderSize`.
- VoiceOver reads the label; nothing is drawn for it.

### Action Button (atom, `DS.ActionButton`)
- `DS.ActionButton(data: DK.ActionButton)`; label `title` in Typography body semibold; `.actionButtonStyle(_:)` on any container sets `DS.ActionButton.Style` (primary, secondary, tertiary, success, destructive) for the buttons inside.
- States: normal; disabled (data `.disabled`): the native disabled look, no taps; loading (data `.loading`, or an action running past the delay): label hidden keeping its width, a small Activity Indicator labelled with the title in its place, taps ignored.
- HIG: native bordered, bordered prominent and borderless buttons on every platform; Return and Esc as the default and cancel keys (Mac, and iPhone and iPad with a hardware keyboard).

### Status Icon (atom, `DS.StatusIcon`)
- `DS.StatusIcon(_ status: DK.Status, size: CGFloat, label: Text? = nil)`; the owner passes its own size token value.
- Symbols: info `info.circle.fill`, success `checkmark.circle.fill`, warning `exclamationmark.triangle.fill`, error `xmark.octagon.fill`; color `statusIcon.color(status)`.
- Hidden from VoiceOver unless the owner gives a label, which it then reads.

### Inline Alert (molecule, `DS.InlineAlert`)
- `DS.InlineAlert(_ alert: DK.InlineAlert)`: one Status Icon in the alert's status, then each notice in order: title (body semibold, Foreground.primary), message below (body, Foreground.secondary), wrapping to as many lines as needed.
- Static: no actions, no dismissal, no focus. Full available width, leading-aligned.
- Background, border and icon in the alert's status (the most severe notice's).
- VoiceOver: one element reading the status label, then every title and message in order.

### Edge Case (molecule, `DS.EdgeCaseView`)
- `DS.EdgeCaseView(_ edgeCase: DK.EdgeCase)`, wrapping the system unavailable-content view, so it centers itself and adapts to the space it gets.
- Icon: `.symbol` the system label symbol in Foreground.secondary; `.image` a square of `edgeCase.iconSize`, corners `edgeCase.imageRadius`, filling the square; `.monogram` initials centered on a circle of `edgeCase.iconSize` in the tint's colors.
- Title (Typography title bold, Foreground.primary); message (body, Foreground.secondary), hidden when empty; actions stacked vertically, centered, in order, each a `DS.ActionButton`.

### Showcase pages (DemoApps)
- Sidebar Atoms: Action Button, Activity Indicator, Status Icon; Molecules: Edge Case, Inline Alert; one file and one catalog entry each (package-and-showcase BR-8).
- Playground (architecture §7): a control per configuration-relevant input and per data field, the session's Theme, Amendment, Appearance and Text size, and the live `DK.{Name}(…)` or `DS.{Name}(…)` snippet.
  - Activity Indicator: control size (five), label.
  - Action Button: title, role (four, none included), state (three), style override (none and five), action duration (instant, 1 s, 3 s).
  - Status Icon: status (four), label on or off.
  - Inline Alert: one to three notices, each with status, title and message.
  - Edge Case: icon kind (symbol, image, monogram), symbol name, monogram initials and tint (five), title, message, zero to three actions with role.
- Variants, light and dark: every control size; every role × state and every style override × role; every status; every status of a one-notice alert plus a two-notice alert of mixed statuses; each icon kind with and without message and actions.
- Configuration: each component token with its chain (component → semantic → primitive), from the inventory.

## Data
- `DK.Status`: enum `info`, `success`, `warning`, `error`; `Comparable` by severity in that order (error most severe), `CaseIterable`, `Sendable`.
- `DK.InlineAlert`: `notices: [Notice]` — at least one; `status: DK.Status` — the maximum of the notices' statuses. `init?(notices:)` (nil for none); `init(_ notice: Notice, _ others: Notice...)`.
- `DK.InlineAlert.Notice`: `status: DK.Status` — default `info`; `title: String`; `message: String`.
- `DS.ActionButton.Style`: enum `primary`, `secondary`, `tertiary`, `success`, `destructive`, `CaseIterable`, `Sendable`; environment value optional, `nil` by default.
- Component tokens (standard theme):

| Configuration | Token | Alias | Scales |
|---|---|---|---|
| activityIndicator | largePlaceholderSize | size48 | yes |
| activityIndicator | extraLargePlaceholderSize | size64 | yes |
| actionButton | activityIndicatorDelay | Motion.quick | — |
| statusIcon | color(info, success, warning, error) | Foreground.info, .success, .warning, .critical | — |
| inlineAlert | background(info, success, warning, error) | Background.infoSubtle, .successSubtle, .warningSubtle, .criticalSubtle | — |
| inlineAlert | border(info, success, warning, error) | Border.info, .success, .warning, .criticalSubtle | — |
| inlineAlert | borderWidth | BorderWidth.thin | — |
| inlineAlert | radius | Radius.medium | — |
| inlineAlert | padding | Spacing.medium (Q-1) | — |
| inlineAlert | iconSize | size16 | yes |
| inlineAlert | iconSpacing | Spacing.small | — |
| inlineAlert | noticeSpacing | Spacing.small | — |
| inlineAlert | titleSpacing | Spacing.xxSmall | — |
| edgeCase | iconSize | size64 | yes |
| edgeCase | imageRadius | Radius.large | — |

- `DK.AccentTint` colors: background Background.{brand, info, success, warning, critical}Subtle, foreground Foreground.{brand, info, success, warning, critical}.

## Rules
- BR-1 Port: each component starts from its FinanceTracker file (`DS+ActivityIndicator.swift`, `DS+ActionButton.swift`, `DS+InlineAlert.swift`, `DS+EdgeCaseView.swift`, `DK+InlineAlert.swift`), public names and signatures kept, with these deviations only: `DK.CallToAction` is `DK.ActionButton` (already ported); `DK.InlineAlert.Style` becomes `DK.Status` with four cases and `Notice.style` becomes `Notice.status` (Q-4); the Inline Alert icon is a `DS.StatusIcon` in Foreground colors, not OnBackground subtle ones (canvas changelog, 24 October 2026); `DS.EdgeCaseView` renders `DK.Icon`, not a symbol name (package-and-showcase BR-3); the component tokens of Data replace FinanceTracker's literal configuration values; `DS.StatusIcon` is new.
- BR-2 Activity Indicator: mini, small and regular draw the native spinner; on iPhone and iPad, sizes the platform doesn't distinguish render at its nearest system size. large and extraLarge draw `progress.indicator` without animation at their tokens, in Foreground.brand. The label is the accessibility label in every size.
- BR-3 Action Button look, from role and style override (override `nil` = none):

| Role | No override | primary or success | secondary | tertiary | destructive |
|---|---|---|---|---|---|
| primary | prominent, Background.brand, OnBackground.brand label | prominent, Background.brand / .success, OnBackground label | bordered | borderless, Foreground.brand label | prominent, Background.critical, OnBackground.critical label |
| destructive | bordered, Foreground.critical label | bordered, Foreground.critical label | bordered | borderless, Foreground.brand label | bordered, Foreground.critical label |
| cancel, none | bordered | prominent, Background.brand / .success | bordered | borderless, Foreground.brand label | bordered, Foreground.critical label |

  Bordered buttons keep the native neutral look, never the scene tint. In an inactive Mac window prominent labels take the system's inactive look. Disabled overrides every look with the native disabled one.
- BR-4 Action Button behavior: a tap runs `action` on the main actor; while it runs further taps are ignored; if it runs longer than `activityIndicatorDelay` the loading look appears until it returns, both transitions animated with Motion.quick; a quicker action never shows the indicator. Data state `.loading` shows the loading look at once and ignores taps; `.disabled` ignores taps.
- BR-5 Action Button keys and roles: primary is the default action (Return), cancel the cancel action (Esc), destructive and none have no key; destructive and cancel set the matching system button role. VoiceOver reads the title.
- BR-6 Status Icon: color `statusIcon.color(status)`, size the owner's value (no token of its own), hidden from accessibility without a label, read with one.
- BR-7 Inline Alert: the alert's status is its most severe notice's (error, warning, success, info) and sets the icon, background and border; notices `noticeSpacing` apart, title and message `titleSpacing` apart, icon `iconSpacing` before the text, `padding` inside, `radius` corners, `borderWidth` border. The icon is vertically centered on the first line of the first title at every text size.
- BR-8 Inline Alert accessibility: one combined element; the icon's label is the status word of Copy for every status (Q-3), read before the notices.
- BR-9 Edge Case: the system unavailable-content view lays out icon, title, description and actions; the message is omitted when empty; actions keep their order and each is a `DS.ActionButton`, so a primary action is the default key. Image and monogram are `edgeCase.iconSize` (Q-2); image data is decoded with ImageIO (Q-5); undecodable data draws the symbol `photo` in Foreground.secondary instead. Monogram initials in Typography title2 semibold in the tint's foreground on its background (Data). The icon is hidden from VoiceOver; title, message and actions are read.
- BR-10 Configuration: every token of Data is a property of its component configuration in `DS.Theme.Components`, read only through `@MDS(\.{component})`; every built-in theme defines it (a missing one fails to compile); the four tokens marked "scales" join the text-bound scaling list (theme-and-tokens BR-7); `size48` and `size64` join the `size` primitives in order.
- BR-11 The sample amendment overrides `inlineAlert.radius` with Radius.large (theme-and-tokens BR-10).
- BR-12 Copy: DesignSystem gets a String Catalog (`Sources/DesignSystem/Resources/Localizable.xcstrings`, resources declared in `Package.swift`); package-and-showcase BR-1 ("no resources") is marked superseded by this rule in the same slice. Keys `designSystem.{component}.{element}`, pl and en. Showcase copy stays English literals (package-and-showcase BR-6).
- BR-13 Previews: each component file has a light and a dark preview showing its variants; the Activity Indicator previews render without `.theme(_:)` (theme-and-tokens BR-9 default).
- BR-14 Lifecycle: once a component's showcase page is done, its canvas page header shows Implemented and `components.md` (skill `design-system`) gets its entry; the canvas Foundations primitives board lists `size48` and `size64`; the Inline Alert canvas snippet and Configuration show `Notice.status: DK.Status` (Q-4).
- BR-15 DesignSystem may import ImageIO, for decoding image data only (Q-5); the slice adding it updates the workspace `CLAUDE.md` › Allowed imports (DesignSystem: DesignKit, SwiftUI, ImageIO) and `docs/architecture.md` §3 in the same change.

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.inlineAlert.info | Informacja | Information |
| designSystem.inlineAlert.success | Sukces | Success |
| designSystem.inlineAlert.warning | Ostrzeżenie | Warning |
| designSystem.inlineAlert.error | Błąd | Error |

## Acceptance criteria
- AC-1 (manual) Given the Activity Indicator page, when each control size is chosen, then mini, small and regular show the spinning native indicator and large and extraLarge the static `progress.indicator` symbol at 48 and 64 pt in the brand color, in light and dark.
- AC-2 (manual) Given the Mac showcase at text size 200 %, when the Activity Indicator shows large, then the symbol is 96 pt; on iPhone at the largest accessibility text size it grows likewise (BR-10, theme-and-tokens BR-7).
- AC-3 (manual) Given VoiceOver on an Activity Indicator labelled "Loading", when it is focused, then VoiceOver reads "Loading" in every size.
- AC-4 (manual) Given the Action Button Variants, when each role × state and each override × role is shown, then every look matches BR-3 in light and dark, including primary under destructive as prominent critical and destructive under primary and success staying bordered critical.
- AC-5 (manual) Given an Action Button with a 3 s action, when it is tapped, then the label gives way to a small indicator after 150 ms, further taps do nothing, and the label returns when the action ends; given an instant action, then no indicator appears.
- AC-6 (manual) Given an Action Button with state `.loading`, when it is shown, then the indicator shows at once and taps do nothing; with `.disabled`, then it has the native disabled look and taps do nothing.
- AC-7 (manual) Given a primary and a cancel Action Button on the Mac, when Return and then Esc are pressed, then each runs its own action; on iPad with a hardware keyboard likewise.
- AC-8 (manual) Given a primary Action Button in a Mac window that loses focus, when the window is inactive, then its label takes the system's inactive look; given a bordered button under a brand scene tint, then it stays neutral.
- AC-9 (manual) Given VoiceOver on an Action Button titled "Try again", when it is loading, then VoiceOver still reads "Try again".
- AC-10 (manual) Given the Status Icon page, when each status is shown, then it draws its symbol of the Status Icon section in Foreground.info, .success, .warning and .critical, light and dark; with the label off VoiceOver skips it, with it on VoiceOver reads it.
- AC-11 (manual) Given a two-notice Inline Alert with an info and a warning notice, when it is shown, then it has one warning icon, the warning background and border, both notices in order with titles semibold and messages secondary, in light and dark; given notices of every status, then error wins over warning, warning over success, success over info.
- AC-12 (manual) Given an Inline Alert at text sizes 85 % and 200 % on the Mac, when it renders, then the icon scales and stays centered on the first title line while padding, spacing, radius and border stay fixed.
- AC-13 (manual) Given VoiceOver in Polish and in English on an error Inline Alert, when it is focused, then one element reads "Błąd" / "Error" and then each title and message.
- AC-14 (manual) Given the Edge Case page, when each icon kind is shown, then a symbol uses the system size in the secondary color, an image is a 64 pt square with 12 pt corners and a monogram a 64 pt circle with the tint's colors for each of the five tints; with an empty message no message line shows; with actions they stack in order and a primary one answers Return.
- AC-15 (manual) Given an Edge Case whose image data can't be decoded, when it renders, then the `photo` symbol shows in the secondary color.
- AC-16 (manual) Given the Component tokens page, when Theme standard and Amendment none are chosen, then every token of Data shows with its chain; with Amendment sample, then `inlineAlert.radius` shows Radius.large, and the Inline Alert Playground under the sample amendment draws 12 pt corners (BR-11; foundations-pages BR-6).
- AC-17 (manual) Given each of the five pages, when Theme, Amendment, Appearance and Text size are changed, then the Playground follows them and the snippet shows the current data; Variants show light and dark.
- AC-18 (manual) Given Xcode previews of each component file, when they render, then a light and a dark preview show; the Activity Indicator previews render the standard theme without `.theme(_:)`.
- AC-19 Given a theme missing any token of Data, when the package builds, then it fails to compile (BR-10); given the String Catalog, then every key of Copy has pl and en.

## Open questions
- None.
