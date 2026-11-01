# Form control sizes
Status: Draft · Repo: DesignKit · Feature: foundations · Module or target: DesignSystem, DemoApps · Depends on: foundations/theme-and-tokens, foundations/primitives-in-design-system

## Goal
The size primitives that the approved form controls need and the Foundations page doesn't list yet: the width of a Stepper's value field (components/stepper) and the minimum width of a Field Row's control area at regular width (components/form-field-row). No semantic token changes: the other controls use the native look (components/choice-pickers Q-1, components/date-picker Q-1).

## Scope
- In:
  - Primitives `size56` and `size320` on the `size` scale (`DS.Theme.SizePrimitive`)
  - Canvas "Foundations · Tokens", primitives board: both on the `size` scale
- Out:
  - The component tokens that alias them: `stepper.valueFieldWidth` (components/stepper), `fieldRow.controlMinWidth` (components/form-field-row)
  - Semantic tokens for a raised segment or a shadow: not needed, since the Segmented Control is native (components/choice-pickers Q-1)

## User stories
- US-1 As a DesignKit developer I want each size an approved component uses to exist as a primitive so that the component's configuration aliases a token instead of a literal.

## Data
- `size` scale (pt), in order: size12 · size16 · size20 · size24 · size48 · size56 · size64 · size320 · size480 · size560 · size640

## Rules
- BR-1 The `size` scale gains `size56` (56 pt) and `size320` (320 pt), in ascending order of value, `internal` like every primitive (primitives-in-design-system BR-1); names and values as Data, matching the canvas (theme-and-tokens BR-2).
- BR-2 No theme or amendment aliases them in this spec; a primitive with no reader is allowed until the component specs that read it land.
- BR-3 The token inventory lists both through the scale's `all` (theme-and-tokens BR-14), so the showcase Foundations › Primitive tokens page shows them with no page change.
- BR-4 Lifecycle: approved only once the canvas Foundations primitives board lists `size56` and `size320` and the page is `Approved`.

## Acceptance criteria
- AC-1 (manual) Given the showcase Foundations › Primitive tokens page on macOS, iPadOS and iOS, when shown, then the `size` scale reads as Data, in order, `size56` at 56 pt and `size320` at 320 pt (BR-1, BR-3).
- AC-2 (manual) Given the canvas Foundations page, when compared with the showcase page, then the `size` scale is the same (BR-1, BR-4).
- AC-3 Given `swiftlint lint --strict`, when run on the changed files, then no violation (BR-1).

## Open questions
- None.

## Changelog
- 2026-11-01 Drafted from the Design System canvas: sizes for the approved Stepper and Field Row (create-spec)
