import DesignKit

extension DK.SupportText {
    var content: String {
        switch self {
        case .footnote(let text), .message(let text), .error(let text): text
        }
    }

    var errorContent: String? {
        if case .error(let text) = self { text } else { nil }
    }

    var isFootnote: Bool {
        if case .footnote = self { true } else { false }
    }
}
