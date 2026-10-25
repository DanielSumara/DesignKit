extension DK {
    public enum Status: CaseIterable, Comparable, Sendable {
        case info
        case success
        case warning
        case error
    }
}
