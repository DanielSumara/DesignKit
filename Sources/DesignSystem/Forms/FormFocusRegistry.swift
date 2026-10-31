@MainActor
internal final class FormFocusRegistry {
    private var handlers: [FieldID: @MainActor @Sendable (Bool) -> Void] = [:]

    func register(_ id: FieldID, handler: @escaping @MainActor @Sendable (Bool) -> Void) {
        handlers[id] = handler
    }

    func notify(_ id: FieldID, focused: Bool) {
        handlers[id]?(focused)
    }

    func prune(keeping ids: Set<FieldID>) {
        handlers = handlers.filter { ids.contains($0.key) }
    }
}
