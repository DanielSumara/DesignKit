extension DS.Theme.Components {
    public struct ModalSheet: Equatable, Sendable {
        public internal(set) var standardWidth: Size
        public internal(set) var wideWidth: Size
        public internal(set) var maxHeight: Size
        public internal(set) var headerSpacing: Spacing
        public internal(set) var contentSpacing: Spacing
        public internal(set) var padding: Spacing

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            headerSpacing.resolve(against: semanticTokens)
            contentSpacing.resolve(against: semanticTokens)
            padding.resolve(against: semanticTokens)
        }
    }
}
