# Primitives in DesignSystem — implementation plan
Spec: DesignKit/docs/specs/foundations/primitives-in-design-system.md
Repo: DesignKit
Status: Done
Run base: a24d291eb7901aac11c7b94a84df6b8951e75fcf

## Slices
### S1 — DesignSystem: move and narrow the primitive tier
- ACs: AC-1, AC-2, AC-5
- Area: `Sources/DesignKit/Primitives/`, `Sources/DesignSystem/Tokens/Primitives/`, `Sources/DesignSystem/Tokens/`, `Sources/DesignSystem/Inventory/`
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `DS.Theme.Primitive` (`scale`, `all`, `name`; `Sendable`, `Hashable`) in `Tokens/Primitives/DS.Theme+Primitive.swift`; `DS.Theme.ColorPrimitive`, `SpacePrimitive`, `SizePrimitive`, `RadiusPrimitive`, `StrokePrimitive`, `DurationPrimitive`, `OpacityPrimitive`, `FontSizePrimitive` in `Tokens/Primitives/DS.Theme+{Scale}Primitive.swift`, all default `internal` access, with the members, values and `all` order of their `DK.` counterparts; `Sources/DesignKit/Primitives/` removed; `DK.` primitive references updated in `Tokens/DS.Theme+AdaptiveColor.swift`, `Tokens/DS.Theme.SemanticTokens+{Spacing,Radius,BorderWidth,Motion,Typography}.swift`, `Inventory/DS.Theme.Inventory+Primitives.swift` and `Inventory/DS.Theme.Inventory+Semantic.swift`; themes (`Theme/DS.Theme+Standard.swift`) and amendments (`Theme/DS.Theme+Amendment.swift`) keep their leading-dot members unchanged
- Done when: AC-1 search of `Sources/` and `DemoApps/` finds no `DK.` primitive type name, `Sources/DesignKit/Primitives/` is gone and the new directory holds the protocol and eight scales; AC-5 search of `Sources/DesignSystem/Tokens/Primitives/` finds no `package` or `public`; AC-2 fault injection in a `DemoApps/` file naming `DS.Theme.SpacePrimitive.space16` fails to compile, with and without the `@_spi(Showcase)` import, then is removed; lint clean; package and iOS DesignSystem builds pass; `git diff -M` shows moved files with only the `DK.` → `DS.Theme.` and access changes
- Manual ACs: —

### S2 — Verification: gate, showcase pages, owner documents
- ACs: AC-3, AC-4
- Area: `DesignKit`, `DemoApps/` (verification only)
- Depends on: S1
- Skills: design-system
- Review: diff-only
- Builds: no code; confirms the owner documents state the placement of BR-1 — workspace `CLAUDE.md` › Structure, `DesignKit/CLAUDE.md` › Rules › Targets, `docs/architecture.md` §2 layout, §3 target table, the placement note and §4 Primitive row, skill `design-system` › Tokens › Primitive, theme-and-tokens BR-1 superseded note — editing one only if it drifted
- Done when: `scripts/gate.sh` passes every step (lint, package build, iOS build, xcodegen, ShowcasePhone, ShowcasePad, ShowcaseMac) and `git diff` shows no change under `DemoApps/` (AC-3); the owner documents read as BR-1 says; lint clean
- Manual ACs: AC-4

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S1 | search of `Sources/` and `DemoApps/`; directory check |
| AC-2 | S1 | compile-fail check in `DemoApps/`, with and without the SPI import |
| AC-3 | S2 | `scripts/gate.sh` and no `DemoApps/` diff |
| AC-4 | S2 | manual, three showcase apps |
| AC-5 | S1 | search of `Sources/DesignSystem/Tokens/Primitives/` |

## Manual verification
- AC-4 — run ShowcaseMac, ShowcasePhone and ShowcasePad; open Foundations › Primitives, Semantic tokens and Component tokens: entries, values, alias chains and their order match the state before the move, in light and dark

## Out of scope
- Any change to primitive names, values, scales or order, semantic or component tokens, themes, amendments, `mds` APIs, the inventory's SPI types or the showcase (spec Scope › Out)
- Any file under `DemoApps/` (AC-3)
- New themes (separate spec)

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Done | a24d291 | 543404c | 1 fixed / 0 rejected |
| S2 | Done | d240f56 | HomeBudgetApps a75d7bf | 2 fixed / 3 rejected |

## Open questions
- None
