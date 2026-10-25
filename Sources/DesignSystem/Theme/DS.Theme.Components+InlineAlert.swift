extension DS.Theme.Components {
    public struct InlineAlert: Equatable, Sendable {
        public internal(set) var background: StatusColors
        public internal(set) var border: StatusColors
        public internal(set) var borderWidth: BorderWidth
        public internal(set) var radius: Radius
        public internal(set) var padding: Spacing
        public internal(set) var iconSize: Size
        public internal(set) var iconSpacing: Spacing
        public internal(set) var noticeSpacing: Spacing
        public internal(set) var titleSpacing: Spacing

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            borderWidth.resolve(against: semanticTokens)
            radius.resolve(against: semanticTokens)
            padding.resolve(against: semanticTokens)
            iconSpacing.resolve(against: semanticTokens)
            noticeSpacing.resolve(against: semanticTokens)
            titleSpacing.resolve(against: semanticTokens)
        }
    }
}
