# Base molecules
Status: Implemented · Repo: DesignKit · Feature: components · Module or target: DesignKit, DesignSystem, DemoApps · Depends on: components/base-atoms, foundations/theme-and-tokens, foundations/foundations-pages, foundations/package-and-showcase

Split from base-components (Q-6); ids are kept from it, so gaps are the rules and criteria of components/base-atoms.
Ids of another spec are cited with its name: `base-atoms BR-10`, `base-molecules BR-10`; a bare id is this spec's (BR-10, BR-13, BR-14, AC-17, AC-18 and AC-19 exist in both specs, one per side); new ids continue after the highest id used in either spec (currently AC-35, in base-molecules).

## Goal
The first two DesignSystem molecules, both `Approved` on the Design System canvas, ported from FinanceTracker (`Kits/DesignKit/Sources/DesignKitUI/Molecules`) and brought to their canvas look: Inline Alert and Edge Case, composed of the base atoms. Each gets its component tokens, light and dark previews and a showcase page. They bring DesignSystem its String Catalog and the first component override of the sample amendment.

## Scope
- In:
  - `DK.InlineAlert` (ported, with `Style` → `Status` and `Notice.style` → `Notice.status`, BR-1); `DK.EdgeCase`, `DK.Icon`, `DK.AccentTint` used as ported (package-and-showcase BR-3)
  - `DS.InlineAlert`, `DS.EdgeCaseView`
  - Component configurations `inlineAlert`, `edgeCase` in `DS.Theme.Components`, their text-bound sizes on the scaling list
  - The `DK.AccentTint` color mapping (theme-and-tokens Scope Out); the sample amendment's component override (theme-and-tokens BR-10)
  - DesignSystem's String Catalog and its first keys; the ImageIO import
  - Two showcase pages; canvas status Implemented and `components.md` entries once implemented
- Out:
  - Activity Indicator, Action Button, Status Icon, `DK.Status` (components/base-atoms)
  - `DK.Tone` mapping and `foregroundStyle(tone:)`; `DK.Alert` and its alert modifier
  - Loadable view, progress bar, field errors, badges; platform design-system targets (nothing here differs per platform beyond native controls)
  - No per-platform differences: the layout adapts to the space given (AC-30)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Alert w treści | Inline alert | A static note in the content gathering one place's notices |
| Komunikat | Notice | One title and message of an inline alert, with its status (base-atoms Glossary) |
| Przypadek brzegowy | Edge case | Fills a screen or region with nothing to show: empty, failed, not allowed |
| Monogram | Monogram | Initials on a tinted circle |

## User stories
- US-4 As an app developer I want an inline alert gathering several notices in one tone so that a screen explains itself without interrupting the user.
- US-5 As an app developer I want an edge case view for empty, failed and not-allowed states so that every such state looks native and offers its next step.
- US-6 As a VoiceOver user I want alerts and edge cases labelled so that I hear how severe a note is and what I can do next.
- US-7 As a DesignKit developer I want a showcase page per component so that every variant, configuration and token chain can be checked without reading code.

## Screens & navigation
### Inline Alert (molecule, `DS.InlineAlert`)
- `DS.InlineAlert(_ alert: DK.InlineAlert)`: one Status Icon (base-atoms BR-6) in the alert's status, then each notice in order: title (body semibold, Foreground.primary), message below (body, Foreground.secondary), wrapping to as many lines as needed; an empty title or message is not drawn.
- Static: no actions, no dismissal, no focus. Full available width, leading-aligned.
- Background, border and icon in the alert's status (the most severe notice's).
- VoiceOver: one element reading the status label, then every title and message in order.
- The error alert's border is Border.criticalSubtle, unlike the other statuses (Data table); this is by design (AC-29).

### Edge Case (molecule, `DS.EdgeCaseView`)
- `DS.EdgeCaseView(_ edgeCase: DK.EdgeCase)`, wrapping the system unavailable-content view, so it centers itself and adapts to the space it gets.
- Icon: `.symbol` the system label symbol in Foreground.secondary; `.image` a square of `edgeCase.iconSize`, corners `edgeCase.imageRadius`, filling the square; `.monogram` initials centered on a circle of `edgeCase.iconSize` in the tint's colors.
- Title (Typography title bold, Foreground.primary); message (body, Foreground.secondary), hidden when empty; actions stacked vertically, centered, in order, each a `DS.ActionButton` (base-atoms).

### Showcase pages (DemoApps)
- Sidebar Molecules: Edge Case, Inline Alert; one file and one catalog entry each (package-and-showcase BR-8).
- Playground (architecture §7): a control per configuration-relevant input and per data field, the session's Theme, Amendment, Appearance and Text size, and the live `DK.{Name}(…)` snippet.
  - Inline Alert: one to three notices, each with status, title and message.
  - Edge Case: icon kind (symbol, image, image with undecodable data, monogram), symbol name, monogram initials and tint (five), title, message, zero to three actions with role. The image is a DemoApps asset read as `Data`; the undecodable data is a few arbitrary bytes.
- Variants, light and dark: every status of a one-notice alert plus a two-notice alert of mixed statuses; each icon kind, the undecodable image included, with and without message and actions.
- Configuration: each component token with its chain (component → semantic → primitive), from the inventory.

## Data
- `DK.InlineAlert`: `notices: [Notice]` — at least one; `status: DK.Status` — the maximum of the notices' statuses. `init?(notices:)` (nil for none); `init(_ notice: Notice, _ others: Notice...)`.
- `DK.InlineAlert.Notice`: `status: DK.Status` — default `info`; `title: String`; `message: String`.
- Component tokens (standard theme), scoped by base-atoms BR-16:

| Configuration | Token | Alias | Scales |
|---|---|---|---|
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

- `DK.AccentTint` colors, `internal` to DesignSystem: background Background.{brand, info, success, warning, critical}Subtle, foreground OnBackground.{brand, info, success, warning, critical}Subtle (Q-9).

## Rules
- BR-1 Port: each component starts from its FinanceTracker file (`DS+InlineAlert.swift`, `DS+EdgeCaseView.swift`, `DK+InlineAlert.swift`), public names and signatures kept, with these deviations only: `DK.CallToAction` is `DK.ActionButton` (already ported); `DK.InlineAlert.Style` becomes `DK.Status` with four cases and `Notice.style` becomes `Notice.status` (Q-4); the Inline Alert icon is a `DS.StatusIcon` in Foreground colors, not OnBackground subtle ones (canvas changelog, 24 October 2026); `DS.EdgeCaseView` renders `DK.Icon`, not a symbol name (package-and-showcase BR-3); the component tokens of Data replace FinanceTracker's literal configuration values.
- BR-7 Inline Alert: the alert's status is its most severe notice's (error, warning, success, info) and sets the icon, background and border; notices `noticeSpacing` apart, title and message `titleSpacing` apart, icon `iconSpacing` before the text, `padding` inside, `radius` corners, `borderWidth` border. An empty title or message is omitted with its spacing; a notice with neither is not drawn, and an alert whose notices have neither draws nothing. The icon is vertically centered on the first drawn line at every text size.
- BR-8 Inline Alert accessibility: one combined element; the icon's label is the status word of Copy for every status (Q-3), read before the notices.
- BR-9 Edge Case: the system unavailable-content view lays out icon, title, description and actions; the message is omitted when empty; actions keep their order and each is a `DS.ActionButton`, so a primary action is the default key. Image and monogram are `edgeCase.iconSize` (Q-2); image data is decoded with ImageIO (Q-5); undecodable data draws the symbol `photo` in Foreground.secondary instead. Monogram initials in Typography title2 semibold in the tint's foreground on its background (Data), drawn as given on one line, scaling until it fits the circle and never wrapping. The icon is hidden from VoiceOver; title, message and actions are read.
- BR-10 Configuration: every token of Data is a property of its component configuration in `DS.Theme.Components`, read only through `@MDS(\.{component})`; every built-in theme defines it (a missing one fails to compile); the two tokens marked "scales" join the text-bound scaling list (theme-and-tokens BR-7).
- BR-11 The sample amendment overrides `inlineAlert.radius` with Radius.large (theme-and-tokens BR-10).
- BR-12 Copy: DesignSystem gets a String Catalog (`Sources/DesignSystem/Resources/Localizable.xcstrings`, resources declared in `Package.swift`); package-and-showcase BR-1 ("no resources") is marked superseded by this rule in the same slice. Keys `designSystem.{component}.{element}`, pl and en; the status words are named for the Status Icon, so every owner of a labelled Status Icon reuses them. Showcase copy stays English literals (package-and-showcase BR-6).
- BR-13 Previews: each component file has a light and a dark preview showing its variants.
- BR-14 Lifecycle: before this spec is `Approved`, the Edge Case canvas Configuration shows `edgeCase.iconSize` and `imageRadius` (Q-2) and the monogram draws the OnBackground colors of Data (Q-9), with a changelog entry. Once a component's showcase page is done, its canvas page header shows Implemented and `components.md` (skill `design-system`) gets its entry; the Inline Alert canvas snippet and Configuration show `Notice.status: DK.Status` (Q-4). Checked by AC-31 and AC-33.
- BR-15 DesignSystem may import ImageIO, for decoding image data only (Q-5); the slice adding it updates the workspace `CLAUDE.md` › Allowed imports (DesignSystem: DesignKit, SwiftUI, ImageIO) and `docs/architecture.md` §3 in the same change (AC-32).

## Copy
| Key | pl | en |
|---|---|---|
| designSystem.statusIcon.info | Informacja | Information |
| designSystem.statusIcon.success | Sukces | Success |
| designSystem.statusIcon.warning | Ostrzeżenie | Warning |
| designSystem.statusIcon.error | Błąd | Error |

## Acceptance criteria
- AC-11 (manual) Given a two-notice Inline Alert with an info and a warning notice, when it is shown, then it has one warning icon, the warning background and border, both notices in order with titles semibold and messages secondary, in light and dark; given notices of every status, then error wins over warning, warning over success, success over info.
- AC-12 (manual) Given an Inline Alert at text sizes 85 % and 200 % on the Mac, when it renders, then the icon scales and stays centered on the first title line while padding, spacing, radius and border stay fixed.
- AC-13 (manual) Given VoiceOver in Polish and in English on an error Inline Alert, when it is focused, then one element reads "Błąd" / "Error" and then each title and message.
- AC-14 (manual) Given the Edge Case page, when each icon kind is shown, then a symbol uses the system size in the secondary color, an image is a 64 pt square with 12 pt corners and a monogram a 64 pt circle with the tint's colors of Data for each of the five tints; with an empty message no message line shows; with actions they stack in order and a primary one answers Return.
- AC-15 (manual) Given the Edge Case Playground with icon kind image with undecodable data, when it renders, then the `photo` symbol shows in the secondary color.
- AC-16 (manual) Given the Component tokens page, when Theme standard and Amendment none are chosen, then every token of Data shows with its chain; with Amendment sample, then `inlineAlert.radius` shows Radius.large, and the Inline Alert Playground under the sample amendment draws 12 pt corners (BR-11; foundations-pages BR-6).
- AC-17 (manual) Given each of the two pages, when Theme, Amendment, Appearance and Text size are changed, then the Playground follows them and the snippet shows the current data; Variants show light and dark.
- AC-18 (manual) Given Xcode previews of each component file, when they render, then a light and a dark preview show.
- AC-19 Given a theme missing any token of Data, when the package builds, then it fails to compile (BR-10); given the String Catalog, then every key of Copy has pl and en and package-and-showcase BR-1 is marked superseded by BR-12; both checked once in the slice that adds them.
- AC-21 (manual) Given an Inline Alert whose first notice has an empty title, when it renders, then its message is the first line, the icon is centered on it and no title spacing shows; a notice with an empty message shows only its title.
- AC-22 (manual) Given an Edge Case monogram with the initials "ABCD" at text size 200 % on the Mac, when it renders, then the initials scale until they fit the circle and never wrap.
- AC-27 (manual) Given VoiceOver in Polish and in English on an Edge Case of each icon kind, when it is read, then the icon is skipped and the title, the message (if any) and each action are read in order (BR-9).
- AC-28 (manual) Given the Inline Alert and Edge Case pages on iPhone at the largest accessibility text size, when they render, then the Inline Alert icon scales and stays centered on the first line, the Edge Case icon, image and monogram scale from 64 pt (`edgeCase.iconSize`) without clipping, the monogram initials never wrap, and nothing scrolls horizontally.
- AC-29 (manual) Given an error Inline Alert, when it is shown in light and dark, then its border is Border.criticalSubtle while the other statuses use Border.info, .success, .warning (Data table).
- AC-30 (manual) Given each page on Mac, iPad and iPhone, when it is shown, then the same layout adapts to the space given and no platform-specific variant exists.
- AC-31 (manual) Given the Design System canvas, before this spec is `Approved`, then the Edge Case Configuration shows `edgeCase.iconSize`, `imageRadius` and the OnBackground monogram colors with a changelog entry (BR-14).
- AC-32 Given the slice adding ImageIO, when it is committed, then the workspace `CLAUDE.md` › Allowed imports lists ImageIO for DesignSystem and `docs/architecture.md` §3 matches (BR-15).
- AC-33 (manual) Given a finished showcase page, when checked, then its canvas header shows Implemented, `components.md` has its entry, and the Inline Alert snippet and Configuration show `Notice.status: DK.Status` (BR-14).
- AC-35 (manual) Given an Inline Alert whose notices all have an empty title and an empty message, when it renders, then nothing is drawn: no icon, background or border, and no VoiceOver element (BR-7).

## Open questions
- None.
