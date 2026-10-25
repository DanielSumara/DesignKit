import DesignSystem
import SwiftUI

internal struct ShowcaseEnvironmentModifier: ViewModifier {
    @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment
    #if !os(macOS)
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    #endif

    func body(content: Content) -> some View {
        #if os(macOS)
        content
            .contentTextSize()
            .theme(playgroundEnvironment.resolvedTheme)
            .textSize(playgroundEnvironment.textSize.textSize)
        #else
        content
            .theme(playgroundEnvironment.resolvedTheme)
            .dynamicTypeSize(playgroundEnvironment.textSize.dynamicTypeSize ?? systemDynamicTypeSize)
        #endif
    }
}

extension View {
    func showcaseEnvironment() -> some View {
        modifier(ShowcaseEnvironmentModifier())
    }
}
