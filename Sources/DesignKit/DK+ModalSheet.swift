extension DK {
    public struct ModalSheet: Equatable, Sendable {
        public let title: String
        public let subtitle: String?
        public let cancel: ActionButton
        public let confirm: ActionButton?
        public let confirmsDiscard: Bool

        public init(
            title: String,
            subtitle: String? = nil,
            cancel: ActionButton,
            confirm: ActionButton? = nil,
            confirmsDiscard: Bool = false
        ) {
            self.title = title
            self.subtitle = subtitle
            self.cancel = cancel
            self.confirm = confirm
            self.confirmsDiscard = confirmsDiscard
        }
    }
}
