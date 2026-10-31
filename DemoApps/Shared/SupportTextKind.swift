import DesignKit

internal enum SupportTextKind: String, CaseIterable, Identifiable {
    case none
    case footnote
    case message
    case error

    var id: String { rawValue }

    func supportText(_ text: String) -> DK.SupportText? {
        switch self {
        case .none: nil
        case .footnote: .footnote(text)
        case .message: .message(text)
        case .error: .error(text)
        }
    }

    func snippetArgument(_ text: String) -> String? {
        self == .none ? nil : "supportText: .\(rawValue)(\"\(text.snippetLiteral)\")"
    }
}
