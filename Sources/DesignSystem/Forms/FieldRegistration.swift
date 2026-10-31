internal struct FieldRegistration: Equatable {
    let id: FieldID
    let onFocusChange: @MainActor @Sendable (Bool) -> Void

    static func == (lhs: FieldRegistration, rhs: FieldRegistration) -> Bool {
        lhs.id == rhs.id
    }
}
