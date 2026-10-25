import SwiftUI

internal struct ComponentPageView: View {
    let title: String
    let content: ComponentPage

    @State private var tab: ComponentTab = .playground

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                switch tab {
                case .playground:
                    intro(content.playgroundIntro)
                    content.playground()
                case .variants:
                    intro(content.variantsIntro)
                    ComponentVariantsView(variants: content.variants)
                case .configuration:
                    intro(content.configurationIntro)
                    ComponentConfigurationView(properties: content.properties, tokens: content.tokens)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("Tab", selection: $tab) {
                    ForEach(ComponentTab.allCases) { tab in
                        Text(tab.title).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }

    @ViewBuilder
    private func intro(_ text: String?) -> some View {
        if let text {
            Text(text).foregroundStyle(.secondary)
        }
    }
}

#Preview {
    @Previewable @State var text = "Sample"
    NavigationStack {
        ComponentPageView(
            title: "Sample",
            content: ComponentPage(
                variants: [ComponentVariant(name: "Short") { Text("Label") }],
                properties: [ComponentProperty(name: "sampleText", type: "String", defaultValue: "Sample")],
                playgroundIntro: "Playground intro.",
                playground: {
                    PlaygroundLayout(snippet: "Text(\"\(text)\")") {
                        Text(text)
                    } controls: {
                        TextField("Sample text", text: $text)
                    }
                }
            )
        )
    }
    .environment(PlaygroundEnvironment())
}
