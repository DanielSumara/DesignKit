import SwiftUI

internal struct ComponentVariantsView: View {
    let variants: [ComponentVariant]

    var body: some View {
        if variants.isEmpty {
            Text("None").foregroundStyle(.secondary)
        } else {
            VStack(alignment: .leading) {
                ForEach(variants) { variant in
                    Text(variant.name).font(.headline)
                    HStack(alignment: .top) {
                        rendering(variant, title: "Light", colorScheme: .light)
                        rendering(variant, title: "Dark", colorScheme: .dark)
                    }
                }
            }
        }
    }

    private func rendering(_ variant: ComponentVariant, title: String, colorScheme: ColorScheme) -> some View {
        VStack(alignment: .leading) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            AppearanceSurface(colorScheme: colorScheme, content: variant.view)
        }
    }
}
