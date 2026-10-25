import Foundation

extension DS.Theme.Components {
    public struct Radius: Equatable, Sendable {
        typealias Token = KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value> & Sendable

        let token: Token
        var resolvedPoints: CGFloat = 0

        init(_ token: Token) {
            self.token = token
        }

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            resolvedPoints = CGFloat(semanticTokens.radius[keyPath: token].primitive.points)
        }

        public var points: CGFloat {
            resolvedPoints
        }
    }
}
