extension DK {
    public struct FormField<Value: Equatable>: Equatable {
        public var title: String
        public var value: Value
        public var isOptional: Bool
        public var supportText: SupportText?
        public var onFocusChange: @MainActor @Sendable (Bool) -> Void

        public init(
            title: String,
            value: Value,
            isOptional: Bool = false,
            supportText: SupportText? = nil,
            onFocusChange: @MainActor @Sendable @escaping (Bool) -> Void = { _ in }
        ) {
            self.title = title
            self.value = value
            self.isOptional = isOptional
            self.supportText = supportText
            self.onFocusChange = onFocusChange
        }

        public static func == (lhs: FormField, rhs: FormField) -> Bool {
            lhs.title == rhs.title
                && lhs.value == rhs.value
                && lhs.isOptional == rhs.isOptional
                && lhs.supportText == rhs.supportText
        }
    }
}

extension DK.FormField: Sendable where Value: Sendable {}
