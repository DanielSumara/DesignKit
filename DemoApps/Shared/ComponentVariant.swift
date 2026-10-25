import SwiftUI

internal struct ComponentVariant<Content: View>: View {
    let name: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        Text(name).font(.headline)
        HStack(alignment: .top) {
            rendering(title: "Light", colorScheme: .light)
            rendering(title: "Dark", colorScheme: .dark)
        }
    }

    private func rendering(title: String, colorScheme: ColorScheme) -> some View {
        VStack(alignment: .leading) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            AppearanceSurface(colorScheme: colorScheme, content: content)
        }
    }
}
