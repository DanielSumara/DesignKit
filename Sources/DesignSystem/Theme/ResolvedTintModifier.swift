import SwiftUI

internal struct ResolvedTintModifier: ViewModifier {
    @Environment(\.self) private var environment
    let resolve: ((EnvironmentValues) -> Color.Resolved)?

    func body(content: Content) -> some View {
        if let resolve {
            content.tint(Color(resolve(environment)))
        } else {
            content.tint(Color?.none)
        }
    }
}

extension View {
    internal func resolvedTint(_ resolve: ((EnvironmentValues) -> Color.Resolved)?) -> some View {
        modifier(ResolvedTintModifier(resolve: resolve))
    }
}
