internal enum FormFieldProperties {
    static let all = [
        ComponentProperty(name: "title", type: "String", defaultValue: "none, required"),
        ComponentProperty(name: "value", type: "Value: Equatable", defaultValue: "none, required"),
        ComponentProperty(name: "isOptional", type: "Bool", defaultValue: "false"),
        ComponentProperty(name: "supportText", type: "DK.SupportText?", defaultValue: "nil"),
        ComponentProperty(name: "onFocusChange", type: "@MainActor @Sendable (Bool) -> Void", defaultValue: "{ _ in }")
    ]
}
