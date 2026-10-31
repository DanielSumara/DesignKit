# View state
Status: Not started · Repo: DesignKit · Feature: components · Depends on: components/base-atoms, components/base-molecules, foundations/package-and-showcase

Placeholder: `/create-spec components/view-state` drafts it in place.

## Goal
A DesignSystem view rendering a `DK.ViewState<Content>`: idle draws nothing, loading shows the activity indicator with the caller's label, an edge case shows `DS.EdgeCaseView`, loaded shows the caller's content; one implementation for every screen.

## Needed by
- reminders/configure-reminders/initial-wiring: renders the Reminders root's loading, edge cases and loaded content (BR-2, BR-3, BR-10, AC-12)
