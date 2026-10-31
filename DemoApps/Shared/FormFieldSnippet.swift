internal enum FormFieldSnippet {
    static func make(title: String, value: String, isOptional: Bool, kind: SupportTextKind, text: String) -> String {
        var arguments = [
            "title: \"\(title.snippetLiteral)\"",
            "value: \"\(value.snippetLiteral)\""
        ]
        if isOptional {
            arguments.append("isOptional: true")
        }
        if let support = kind.snippetArgument(text) {
            arguments.append(support)
        }
        return "DK.FormField(\n    " + arguments.joined(separator: ",\n    ") + "\n)"
    }
}
