extension DS {
    public struct Theme: Equatable, Sendable {
        public let id: String
        var semanticTokens: SemanticTokens
        var components: Components
    }
}
