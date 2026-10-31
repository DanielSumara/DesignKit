import SwiftUI

extension DS.Theme.Components {
    public struct ColorToken: Equatable, Sendable {
        typealias Token = KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable

        let token: Token

        init(_ token: Token) {
            self.token = token
        }

        public var color: Color {
            Color(mds: token)
        }
    }
}
