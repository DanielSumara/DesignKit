import SwiftUI

extension Color {
    public init(mds token: KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable) {
        self.init(DS.Theme.TokenColor(group: \.self, token: token))
    }
}
