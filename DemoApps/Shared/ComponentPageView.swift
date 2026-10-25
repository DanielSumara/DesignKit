import SwiftUI

internal struct ComponentPageView<Playground: View, Variants: View>: View {
    let title: String
    let properties: [ComponentProperty]
    let tokens: [ComponentToken]
    let playgroundIntro: String?
    let variantsIntro: String?
    let configurationIntro: String?
    let playground: Playground
    let variants: Variants

    @State private var tab: ComponentTab = .playground

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                switch tab {
                case .playground:
                    intro(playgroundIntro)
                    playground
                case .variants:
                    intro(variantsIntro)
                    variants
                case .configuration:
                    intro(configurationIntro)
                    ComponentConfigurationView(properties: properties, tokens: tokens)
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

extension ComponentPageView {
    init(
        title: String,
        properties: [ComponentProperty] = [],
        tokens: [ComponentToken] = [],
        playgroundIntro: String? = nil,
        variantsIntro: String? = nil,
        configurationIntro: String? = nil,
        @ViewBuilder playground: () -> Playground,
        @ViewBuilder variants: () -> Variants
    ) {
        self.title = title
        self.properties = properties
        self.tokens = tokens
        self.playgroundIntro = playgroundIntro
        self.variantsIntro = variantsIntro
        self.configurationIntro = configurationIntro
        self.playground = playground()
        self.variants = variants()
    }
}

extension ComponentPageView where Variants == NoVariants {
    init(
        title: String,
        properties: [ComponentProperty] = [],
        tokens: [ComponentToken] = [],
        playgroundIntro: String? = nil,
        variantsIntro: String? = nil,
        configurationIntro: String? = nil,
        @ViewBuilder playground: () -> Playground
    ) {
        self.init(
            title: title,
            properties: properties,
            tokens: tokens,
            playgroundIntro: playgroundIntro,
            variantsIntro: variantsIntro,
            configurationIntro: configurationIntro,
            playground: playground,
            variants: { NoVariants() }
        )
    }
}

#Preview {
    @Previewable @State var text = "Sample"
    NavigationStack {
        ComponentPageView(
            title: "Sample",
            properties: [ComponentProperty(name: "sampleText", type: "String", defaultValue: "Sample")],
            playgroundIntro: "Playground intro.",
            playground: {
                PlaygroundLayout(snippet: "Text(\"\(text)\")") {
                    Text(text)
                } controls: {
                    TextField("Sample text", text: $text)
                }
            },
            variants: {
                ComponentVariant(name: "Short") { Text("Label") }
            }
        )
    }
    .environment(PlaygroundEnvironment())
}
