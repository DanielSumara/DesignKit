extension DK {
    public struct CallToAction: Equatable, Sendable, Identifiable {
        public let id: String
        public let title: String
        public let role: Role?
        public let state: State
        public let action: @MainActor () async -> Void

        public init(
            id: String? = nil,
            title: String,
            role: Role? = nil,
            state: State = .normal,
            action: @MainActor @escaping () async -> Void
        ) {
            self.id = id ?? title
            self.title = title
            self.role = role
            self.state = state
            self.action = action
        }

        public static func == (lhs: CallToAction, rhs: CallToAction) -> Bool {
            (lhs.id, lhs.title, lhs.role, lhs.state) == (rhs.id, rhs.title, rhs.role, rhs.state)
        }
    }
}

extension DK.CallToAction {
    public enum Role: Equatable, Sendable {
        case primary
        case destructive
        case cancel
    }

    public enum State: Equatable, Sendable {
        case disabled
        case loading
        case normal
    }
}
