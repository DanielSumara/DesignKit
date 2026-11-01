# Modal sheet height
Status: Draft · Repo: DesignKit · Feature: components · Module or target: DesignSystem, DemoApps · Depends on: components/modal-sheet

## Goal
Let an owner override a Modal Sheet's height on macOS for content that needs more than `maxHeight` (a long form), keeping the sheet independent of its content. iPhone and iPad keep their system sizing.

## Scope
- In:
  - A `height` call-site option of `DS.ModalSheet`, macOS only
  - Canvas page "Template · Modal Sheet" (Approved 1 November 2026, with its Content examples board); showcase page Playground control; `components.md` entry updated
- Out:
  - Every other sheet behavior: components/modal-sheet BR-1 to BR-13, unchanged
  - Content-aware sizing: the sheet knows nothing of its content (components/modal-sheet BR-8)

## User stories
- US-1 As a developer I want a taller sheet on macOS for a long form so that the user scrolls less.

## Data
- `DS.ModalSheet(_ data: DK.ModalSheet, width: Width = .standard, height: CGFloat? = nil, @ViewBuilder content:)`

## Rules
- BR-1 macOS: with `height` nil the sheet sizes as components/modal-sheet BR-7; with a value, `height` takes the place of `maxHeight` in that rule (Q-1, Q-2).
- BR-2 iOS and iPadOS ignore `height` (components/modal-sheet BR-7).
- BR-3 Showcase page "Modal Sheet": the Playground gains a height control (default, 760 pt) and the snippet shows `height:` when set.

## Acceptance criteria
- AC-1 (manual) Given macOS and a long list as content, when presented with `height` nil and with 760, then the sheet stops at `maxHeight` and at 760 pt, the content scrolling inside (BR-1).
- AC-2 (manual) Given iPhone and iPad, when presented with `height` 760, then the sheet sizes as without it (BR-2).
- AC-3 (manual) Given the showcase page, when the height control changes, then the sheet and its snippet follow it; the finished page leaves `components.md` with `height:` in the entry (BR-3).

## Open questions
- Q-1 A `CGFloat` height lets an app pass a literal size, which `CLAUDE.md` › Styling forbids outside the design system. Keep `CGFloat?` as the canvas shows, or offer a token-backed option like `Width` (`Height.standard`, `.tall` → a new `modalSheet.tallHeight`)?
- Q-2 Is `height` a maximum (content shorter than it keeps its own height, as `maxHeight`, drafted) or a fixed height? Does it scale with text size as `maxHeight` does?

## Changelog
- 2026-11-01 Drafted from the Design System canvas "Template · Modal Sheet" (Approved 1 November 2026) (create-spec)
