# Primitives in DesignSystem
Status: Draft · Repo: DesignKit · Feature: foundations · Module or target: DesignKit, DesignSystem · Depends on: foundations/theme-and-tokens

## Goal
Keep all three token tiers in one target: the primitive tier moves from DesignKit to DesignSystem, next to the semantic and component definitions, so a theme's whole mapping is defined and read in one place and DesignKit holds only `DK` data objects. Names, values, themes, amendments and rendering stay as they are.

## Scope
- In:
  - The primitive types (`Primitive` protocol and the scales `color`, `space`, `size`, `radius`, `stroke`, `duration`, `opacity`, `fontSize`) move from `Sources/DesignKit/Primitives/` to `Sources/DesignSystem/Tokens/Primitives/`, renamed from `DK.` to `DS.Theme.` and narrowed from `package` to `internal` (Q-1, Q-2)
  - Every DesignSystem reference updated: semantic tokens, adaptive color, typography, motion, the token inventory
  - Owner documents state the new placement, updated with this spec (Q-3): workspace `CLAUDE.md` › Structure; `DesignKit/CLAUDE.md` › Targets; `docs/architecture.md` §2 tree, §3 target table and placement note, §4 Primitive row; skill `design-system` › Primitive; theme-and-tokens BR-1 superseded by BR-1 here
- Out:
  - Any change to primitive names, values or scales, semantic or component tokens, themes, amendments, `mds` APIs, the inventory's SPI types or the showcase
  - New themes (separate spec)

## Glossary
| PL | EN | Meaning |
|---|---|---|
| Prymityw | Primitive | A raw value (`blue94`, `space16`); only themes and amendments use it (theme-and-tokens Glossary) |

## User stories
- US-1 As a DesignKit developer I want primitives, semantic and component tokens in one target so that I define or change a theme without crossing targets.
- US-2 As an app or Core developer I can't read primitives at all, so that raw values never leak past DesignSystem.

## Screens & navigation
None; no visible change.

## Data
- `DS.Theme.Primitive` (protocol, `internal`): `scale: String` (static), `all: [Self]` (static), `name: String`; `Sendable`, `Hashable`
- `DS.Theme.ColorPrimitive`, `SpacePrimitive`, `SizePrimitive`, `RadiusPrimitive`, `StrokePrimitive`, `DurationPrimitive`, `OpacityPrimitive`, `FontSizePrimitive` (`internal`): the members and values of their `DK.` counterparts, unchanged (theme-and-tokens Data)

## Rules
- BR-1 Supersedes theme-and-tokens BR-1's placement clause: primitive values exist only in DesignSystem, `internal` access, as `DS.Theme.{Scale}Primitive`, one per file `DS.Theme+{Scale}Primitive.swift` in `Sources/DesignSystem/Tokens/Primitives/`. The rest of theme-and-tokens BR-1 (aliasing, compile-time completeness) is unchanged (Q-1, Q-2).
- BR-2 DesignKit holds no token types or values; `Sources/DesignKit/Primitives/` is removed.
- BR-3 No primitive name, value, scale, order, semantic alias or component alias changes; the inventory lists the same entries in the same order (theme-and-tokens BR-2, BR-14).
- BR-4 theme-and-tokens BR-3 holds: no public API exposes a primitive; the `@_spi(Showcase)` inventory keeps its own `PrimitiveValue` and `PrimitiveEntry` types.
- BR-5 The owner documents of Scope › In state this placement from this spec's commit on (Q-3); until the increment lands, the code lags them.

## Copy
None.

## Acceptance criteria
- AC-1 Given the package, when searched for `DK.` followed by a primitive type name or for `Sources/DesignKit/Primitives`, then nothing is found, and `Sources/DesignSystem/Tokens/Primitives/` holds the protocol and the eight scale types.
- AC-2 Given a Swift file in `DemoApps/` or another target of the package, when it names `DS.Theme.SpacePrimitive.space16`, with or without the SPI import, then it fails to compile; checked once in the moving slice.
- AC-3 Given the package, when built for iOS and macOS and its tests run, then all pass with no source change outside DesignKit and DesignSystem.
- AC-4 Given each showcase app, when the Primitives, Semantic tokens and Component tokens pages are opened, then they show the same entries, values and chains as before the move. (manual)

## Open questions
None.
