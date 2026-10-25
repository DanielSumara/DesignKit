extension DK {
    public struct Option<Value: Hashable & Sendable>: Equatable, Sendable, Identifiable {
        public let value: Value
        public let title: String

        public init(value: Value, title: String) {
            self.value = value
            self.title = title
        }

        public var id: Value {
            value
        }
    }
}
