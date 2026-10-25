import SwiftUI

internal struct ComponentConfigurationView: View {
    let properties: [ComponentProperty]
    let tokens: [ComponentToken]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Properties").font(.headline)
            if properties.isEmpty {
                none
            } else {
                Grid(alignment: .leading) {
                    header("Name", "Type", "Default")
                    ForEach(properties) { property in
                        GridRow {
                            Text(property.name).font(.body.monospaced())
                            Text(property.type).font(.body.monospaced())
                            Text(property.defaultValue).font(.body.monospaced())
                        }
                    }
                }
            }
            Text("Component tokens").font(.headline)
            if tokens.isEmpty {
                none
            } else {
                Grid(alignment: .leading) {
                    header("Token", "Alias chain")
                    ForEach(tokens) { token in
                        GridRow {
                            Text(token.token).font(.body.monospaced())
                            Text(token.aliasChain.joined(separator: " → ")).font(.body.monospaced())
                        }
                    }
                }
            }
        }
    }

    private var none: some View {
        Text("None").foregroundStyle(.secondary)
    }

    private func header(_ titles: String...) -> some View {
        GridRow {
            ForEach(titles, id: \.self) { title in
                Text(title).font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }
}
