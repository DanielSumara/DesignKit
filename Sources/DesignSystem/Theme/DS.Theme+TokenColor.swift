import SwiftUI

extension DS.Theme {
    struct TokenColor<Group>: ShapeStyle, Hashable {
        let group: KeyPath<SemanticTokens.Colors, Group> & Sendable
        let token: KeyPath<Group, AdaptiveColor> & Sendable

        func resolve(in environment: EnvironmentValues) -> Color.Resolved {
            environment.theme.semanticTokens.colors[keyPath: group][keyPath: token].resolve(in: environment)
        }
    }
}
