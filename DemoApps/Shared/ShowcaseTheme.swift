import DesignSystem

internal enum ShowcaseTheme: String, CaseIterable, Identifiable {
    case standard

    var id: String { rawValue }

    var title: String {
        switch self {
        case .standard: "Standard"
        }
    }

    var theme: DS.Theme {
        switch self {
        case .standard: .standard
        }
    }
}
