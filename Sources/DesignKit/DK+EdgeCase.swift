extension DK {
    public struct EdgeCase: Equatable, Sendable {
        public let icon: DK.Icon
        public let title: String
        public let message: String
        public let actions: [DK.CallToAction]

        public init(icon: DK.Icon, title: String, message: String, actions: [DK.CallToAction] = []) {
            self.icon = icon
            self.title = title
            self.message = message
            self.actions = actions
        }
    }
}
