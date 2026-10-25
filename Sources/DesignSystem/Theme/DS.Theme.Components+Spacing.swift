import Foundation

extension DS.Theme.Components {
    public struct Spacing: Equatable, Sendable {
        typealias Token = KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value> & Sendable

        let token: Token
        var resolvedPoints: CGFloat = 0

        init(_ token: Token) {
            self.token = token
        }

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            resolvedPoints = CGFloat(semanticTokens.spacing[keyPath: token].primitive.points)
        }

        public var points: CGFloat {
            resolvedPoints
        }
    }
}
