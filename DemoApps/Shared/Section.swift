internal enum Section: String, CaseIterable, Identifiable {
    case foundations
    case atoms
    case molecules
    case organisms
    case templates

    var id: String { rawValue }

    var title: String {
        switch self {
        case .foundations: "Foundations"
        case .atoms: "Atoms"
        case .molecules: "Molecules"
        case .organisms: "Organisms"
        case .templates: "Templates"
        }
    }
}
