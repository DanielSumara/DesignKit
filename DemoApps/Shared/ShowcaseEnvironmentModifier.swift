import DesignSystem
import SwiftUI

internal struct ShowcaseEnvironmentModifier: ViewModifier {
    let includesTextSize: Bool
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

    func body(content: Content) -> some View {
        #if os(macOS)
        content
            .contentTextSize()
            .theme(playgroundEnvironment.resolvedTheme)
            .textSize(includesTextSize ? playgroundEnvironment.textSize.textSize : ShowcaseTextSize.default.textSize)
        #else
        content
            .theme(playgroundEnvironment.resolvedTheme)
            .transformEnvironment(\.dynamicTypeSize) { dynamicTypeSize in
                if includesTextSize, let explicit = playgroundEnvironment.textSize.dynamicTypeSize {
                    dynamicTypeSize = explicit
                }
            }
        #endif
    }
}

extension View {
    func showcaseEnvironment(includesTextSize: Bool = true) -> some View {
        modifier(ShowcaseEnvironmentModifier(includesTextSize: includesTextSize))
    }
}
