import Observation

@MainActor
@Observable
internal final class FocusLog {
    private(set) var lines: [String] = []

    func record(_ title: String, focused: Bool) {
        lines.append("\(title): focused \(focused)")
    }

    func clear() {
        lines.removeAll()
    }
}
