extension DS.Theme.Components {
    public struct FieldRow: Equatable, Sendable {
        public internal(set) var supportTextColor: SupportTextColors
        public internal(set) var errorBorderColor: ColorToken
        public internal(set) var errorBorderWidth: BorderWidth
        public internal(set) var errorBorderRadius: Radius
        public internal(set) var errorFocusRingWidth: BorderWidth
        public internal(set) var supportSpacing: Spacing

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            errorBorderWidth.resolve(against: semanticTokens)
            errorBorderRadius.resolve(against: semanticTokens)
            errorFocusRingWidth.resolve(against: semanticTokens)
            supportSpacing.resolve(against: semanticTokens)
        }
    }
}
