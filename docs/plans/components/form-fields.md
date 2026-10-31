# Form fields — implementation plan
Spec: DesignKit/docs/specs/components/form-fields.md
Repo: DesignKit
Status: Ready
Run base: —
Depends on: —

## Slices
Requires the base-atoms plan `Done` (Action Button for the form showcase) and the foundations plans for theme and showcase.

### S1 — DesignKit, DesignSystem: field data, tokens, String Catalog
- ACs: —
- Area: `Sources/DesignKit/Forms`, `Sources/DesignSystem/Theme`, `Sources/DesignSystem/Inventory`, `Sources/DesignSystem/Resources`, `docs/architecture.md` §2
- Depends on: —
- Skills: design-system
- Review: full
- Builds: `DK.FormField<Value>` and `DK.SupportText` in `Sources/DesignKit/Forms/DK+FormField.swift`, `DK+SupportText.swift` (Data, BR-1, BR-2); `DS.Theme.Components.fieldRow` with all Data tokens, `standard` values, scaling and inventory entries (BR-10); keys `designSystem.fieldRow.optional` and `designSystem.fieldRow.error` pl and en (BR-11); `docs/architecture.md` §2 lists the `Forms/` folders (BR-13)
- Done when: a fault-injected theme missing a `fieldRow` token fails to compile, then removed; every Copy key has pl and en; lint clean; DesignKit and DesignSystem build for iOS and macOS
- Manual ACs: —

### S2 — DesignSystem: Form Text Field and Field Row
- ACs: AC-2, AC-3, AC-9, AC-10, AC-11, AC-15
- Area: `Sources/DesignSystem/Forms`
- Depends on: S1
- Skills: design-system
- Review: full
- Builds: `DS.FormTextField` (BR-8), `DS.FieldRow` (BR-6, BR-7), `EnvironmentValues.fieldShowsError`, error border and focus ring overlay, VoiceOver label, hint and error announcement; light and dark previews (BR-12) in `DS+FormTextField.swift`, `DS+FieldRow.swift`, `EnvironmentValues+FieldShowsError.swift`
- Done when: lint clean; DesignSystem builds for iOS and macOS
- Manual ACs: AC-2, AC-3, AC-9, AC-10, AC-11, AC-15

### S3 — DesignSystem: Form Section and Form with focus order
- ACs: AC-1, AC-4, AC-5, AC-7, AC-8, AC-12
- Area: `Sources/DesignSystem/Forms`
- Depends on: S2
- Skills: design-system
- Review: full
- Builds: `DS.FormSection` (BR-9), `DS.Form` (BR-3, BR-4, BR-5): `@FocusState` ownership, field registration in order, `onFocusChange` calls, Next and Done return keys, Return advance on macOS, left-out fields losing the focus, focused field kept in view; support files under `Forms/` (focus support type, preference or environment keys); light and dark previews, form preview with two sections, optional field, footnote, message and error (BR-12)
- Done when: lint clean; DesignSystem builds for iOS and macOS
- Manual ACs: AC-1, AC-4, AC-5, AC-7, AC-8, AC-12

### S4 — DemoApps: Form showcase pages
- ACs: AC-13, AC-16
- Area: `DemoApps/Shared`
- Depends on: S3
- Skills: design-system
- Review: diff-only
- Builds: pages and Catalog entries Form Text Field, Field Row (Molecules), Form Section (Organisms), Form (Templates) with Playground, live `DK.FormField(…)` snippet, Variants, Configuration `fieldRow` token chains, Form page controls and `onFocusChange` log (BR-14)
- Done when: lint clean; the three Showcase builds pass
- Manual ACs: AC-13, AC-16

### S5 — Docs and canvas: lifecycle
- ACs: AC-14
- Area: Design System canvas, `docs/components.md` (skill `design-system`)
- Depends on: S4
- Skills: design-system
- Review: diff-only
- Builds: the four canvas pages Implemented, `components.md` entries (BR-13)
- Done when: canvas headers, `components.md` and architecture §2 checked
- Manual ACs: AC-14

## AC coverage
| AC | Slice | Verified by |
|---|---|---|
| AC-1 | S3 | manual, Form page on Mac, iPad, iPhone |
| AC-2 | S2 | manual, Field Row page pl and en |
| AC-3 | S2 | manual, Field Row page, Variants |
| AC-4 | S3 | manual, Form page |
| AC-5 | S3 | manual, Form page log |
| AC-7 | S3 | manual, Form page log |
| AC-8 | S3 | manual, Form page, Mac and iOS |
| AC-9 | S2 | manual, VoiceOver |
| AC-10 | S2 | manual, Form Text Field page |
| AC-11 | S2 | manual, Form page disabled toggle |
| AC-12 | S3 | manual, Mac 200 % and iOS largest size |
| AC-13 | S4 | manual, four pages |
| AC-14 | S5 | manual, canvas and docs |
| AC-15 | S2 | manual, VoiceOver pl and en |
| AC-16 | S4 | manual, Xcode previews |

## Manual verification
- AC-1, AC-4, AC-5, AC-7, AC-8, AC-12 — Form showcase page on Mac, iPad and iPhone
- AC-2, AC-3, AC-9, AC-10, AC-11, AC-15 — Field Row, Form Text Field and Form pages, VoiceOver pl and en
- AC-13, AC-16 — all four showcase pages, Xcode previews
- AC-14 — canvas pages, `components.md`, architecture §2

## Out of scope
Per the spec: form-inputs components, validation binding, focus to errors, sheet presentation.

## Progress
| Slice | Status | Base | Head | Review |
|---|---|---|---|---|
| S1 | Pending | — | — | — |
| S2 | Pending | — | — | — |
| S3 | Pending | — | — | — |
| S4 | Pending | — | — | — |
| S5 | Pending | — | — | — |

## Open questions
- None
