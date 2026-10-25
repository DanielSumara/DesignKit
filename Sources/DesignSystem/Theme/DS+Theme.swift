extension DS {
    public struct Theme: Equatable, Sendable {
        final class Base: Sendable {
            let theme: Theme

            init(_ theme: Theme) {
                self.theme = theme
            }
        }

        public let id: String
        var semanticTokens: SemanticTokens
        var components: Components
        var base: Base?

        public static func == (lhs: Theme, rhs: Theme) -> Bool {
            lhs.id == rhs.id
                && lhs.semanticTokens == rhs.semanticTokens
                && lhs.components == rhs.components
        }
    }
}
