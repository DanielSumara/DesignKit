import DesignSystem

internal enum ShowcaseAmendment: String, CaseIterable, Identifiable {
    case plain
    case sample

    var id: String { rawValue }

    var title: String {
        switch self {
        case .plain: "None"
        case .sample: "Sample"
        }
    }

    func apply(to theme: DS.Theme) -> DS.Theme {
        switch self {
        case .plain: theme
        case .sample: theme.amended(by: .sample)
        }
    }
}
