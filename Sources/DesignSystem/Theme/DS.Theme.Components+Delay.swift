import Foundation

extension DS.Theme.Components {
    public struct Delay: Equatable, Sendable {
        let token: KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value> & Sendable
        var resolvedDuration: Duration = .zero

        init(_ token: KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value> & Sendable) {
            self.token = token
        }

        public var duration: Duration {
            resolvedDuration
        }
    }
}
