extension DK {
    public struct EdgeCase: Equatable, Sendable {
        public let icon: DK.Icon
        public let title: String
        public let message: String
        public let actions: [DK.ActionButton]

        public init(icon: DK.Icon, title: String, message: String, actions: [DK.ActionButton] = []) {
            self.icon = icon
            self.title = title
            self.message = message
            self.actions = actions
        }
    }
}
