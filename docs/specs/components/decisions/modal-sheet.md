# Modal sheet: decisions

- Q-1 A reusable modal container in DesignSystem, named `ModalWindow`? Answer: yes, a Template named `ModalSheet`, the HIG term on every platform; it takes a title, an optional subtitle, Cancel and confirm `DK.ActionButton`s and a `@ViewBuilder` content, renders inside the owner's sheet and never presents itself; a discard confirmation driven by the owner's ViewModel (`confirmsDiscard`).
- Q-4 The design-system lifecycle wants an `Approved` canvas page before a component spec. Answer: draft the spec now; the canvas page "Template · Modal Sheet" is made next and must be `Approved` before `review-spec` approves the spec.
