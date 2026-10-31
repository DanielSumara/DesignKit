extension DK {
    public enum SupportText: Equatable, Sendable {
        case footnote(String)
        case message(String)
        case error(String)
    }
}
