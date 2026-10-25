@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct ActivityIndicatorPage: Page {
    static let labelDefault = "Loading"

    let id = "activity-indicator"
    let title = "Activity Indicator"
    let section = Section.atoms

    var content: some View {
        PageContent(title: title)
    }
}

private extension ActivityIndicatorPage {
    static let controlSizes: [(name: String, size: ControlSize)] = [
        ("mini", .mini),
        ("small", .small),
        ("regular", .regular),
        ("large", .large),
        ("extraLarge", .extraLarge)
    ]

    static let properties = [
        ComponentProperty(name: "controlSize", type: "ControlSize (environment)", defaultValue: ".regular"),
        ComponentProperty(name: "label", type: "Text", defaultValue: "none, required")
    ]

    struct PageContent: View {
        let title: String
        @Environment(PlaygroundEnvironment.self) private var playgroundEnvironment

        var body: some View {
            ComponentPageView(
                title: title,
                properties: ActivityIndicatorPage.properties,
                tokens: tokens,
                playgroundIntro: "Playground: the control size and the label, with the shared environment and the code.",
                variantsIntro: "Variants: every control size, in light and dark. "
                    + "Mini, small and regular spin; large and extraLarge show the static symbol.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { Playground() },
                variants: {
                    ForEach(ActivityIndicatorPage.controlSizes, id: \.name) { entry in
                        ComponentVariant(name: entry.name) {
                            DS.ActivityIndicator(label: Text(verbatim: ActivityIndicatorPage.labelDefault))
                                .controlSize(entry.size)
                        }
                    }
                }
            )
        }

        private var tokens: [ComponentToken] {
            playgroundEnvironment.componentTokens(of: "activityIndicator")
        }
    }

    struct Playground: View {
        @State private var sizeName = "regular"
        @State private var label = ActivityIndicatorPage.labelDefault

        var body: some View {
            PlaygroundLayout(snippet: snippet) {
                DS.ActivityIndicator(label: Text(verbatim: label))
                    .controlSize(controlSize)
            } controls: {
                LabeledContent("Control size") {
                    Picker("Control size", selection: $sizeName) {
                        ForEach(ActivityIndicatorPage.controlSizes, id: \.name) { entry in
                            Text(entry.name).tag(entry.name)
                        }
                    }
                    .labelsHidden()
                }
                TextField("Label", text: $label)
            }
        }

        private var controlSize: ControlSize {
            ActivityIndicatorPage.controlSizes.first { $0.name == sizeName }?.size ?? .regular
        }

        private var snippet: String {
            "DS.ActivityIndicator(label: Text(\"\(label.snippetLiteral)\"))\n    .controlSize(.\(sizeName))"
        }
    }
}
