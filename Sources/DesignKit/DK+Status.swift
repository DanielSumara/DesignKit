extension DK {
    public enum Status: CaseIterable, Comparable, Sendable {
        case info
        case success
        case warning
        case error

        private var severity: Int {
            switch self {
            case .info: 0
            case .success: 1
            case .warning: 2
            case .error: 3
            }
        }

        public static func < (lhs: Status, rhs: Status) -> Bool {
            lhs.severity < rhs.severity
        }
    }
}
