import DesignKit
import SwiftUI

extension View {
    public func textSize(_ textSize: DK.TextSize) -> some View {
        #if os(macOS)
        controlSize(textSize.controlSize)
            .environment(\.textSize, textSize)
        #else
        self
        #endif
    }

    public func chromeTextSize() -> some View {
        font(.body)
            .controlSize(.regular)
    }

    public func contentTextSize() -> some View {
        modifier(ContentTextSizeModifier())
    }
}

private struct ContentTextSizeModifier: ViewModifier {
    @Environment(\.textSize) private var textSize

    func body(content: Content) -> some View {
        #if os(macOS)
        content
            .font(mds: \.body)
            .controlSize(textSize.controlSize)
        #else
        content
            .font(mds: \.body)
        #endif
    }
}
