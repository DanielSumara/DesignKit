import CoreGraphics

extension DS.Theme.Components {
    public struct BorderWidth: Equatable, Sendable {
        typealias Token = KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value> & Sendable

        let token: Token
        var resolvedPoints: CGFloat = 0

        init(_ token: Token) {
            self.token = token
        }

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            resolvedPoints = CGFloat(semanticTokens.borderWidth[keyPath: token].primitive.points)
        }

        public var points: CGFloat {
            resolvedPoints
        }
    }
}
