extension DK {
    public struct Alert: Equatable, Sendable {
        public let title: String
        public let message: String
        public let actions: [DK.CallToAction]

        public init(title: String, message: String, actions: [DK.CallToAction]) {
            self.title = title
            self.message = message
            self.actions = actions
        }
    }
}
