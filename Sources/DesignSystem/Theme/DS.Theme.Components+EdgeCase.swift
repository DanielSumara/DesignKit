extension DS.Theme.Components {
    public struct EdgeCase: Equatable, Sendable {
        public internal(set) var iconSize: Size
        public internal(set) var imageRadius: Radius

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            imageRadius.resolve(against: semanticTokens)
        }
    }
}
