internal enum ComponentTab: String, CaseIterable, Identifiable {
    case playground
    case variants
    case configuration

    var id: String { rawValue }

    var title: String {
        switch self {
        case .playground: "Playground"
        case .variants: "Variants"
        case .configuration: "Configuration"
        }
    }
}
