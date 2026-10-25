import SwiftUI

internal struct AppearanceSurface<Content: View>: View {
    let colorScheme: ColorScheme?
    @ViewBuilder let content: () -> Content

    @Environment(\.colorScheme) private var systemColorScheme

    var body: some View {
        content()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background)
            .overlay { Rectangle().stroke(.separator) }
            .environment(\.colorScheme, colorScheme ?? systemColorScheme)
    }
}
