extension DK {
    public struct Alert: Equatable, Sendable {
        public let title: String
        public let message: String
        public let actions: [DK.ActionButton]

        public init(title: String, message: String, actions: [DK.ActionButton]) {
            self.title = title
            self.message = message
            self.actions = actions
        }
    }
}
