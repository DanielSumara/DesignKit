# DesignSystem view state pitfalls
Check: Before changing the layout of `DS.ViewState` or passing it a loaded closure with several root views (AC-9, AC-14).

## Loaded content is single-root (BR-2)
- Tried: placing a multi-root loaded closure (`{ Text("a"); Text("b") }`) through `ViewStateLayout`, a `Layout` that keeps one view identity across cases; also a `Group` or a stack inside the `Layout`.
- Why it fails: `Layout` flattens ViewBuilder tuples and conditionals into separate subviews, which `placeSubviews` puts on top of each other; a container that would group them adds a layout of its own, against BR-2 (no frame, padding or stack added). Dropping the `Layout` for loaded loses the single identity, so an owner's `.task` and `.onAppear` restart on every case change.
- Chosen: loaded content must be a single root view; callers wrap several views themselves.
- Open: the spec and the View State page (S3) do not state the single-root requirement yet.
