import SwiftUI

@MainActor
internal struct PageAnatomyPage: View {
    static let sampleTextDefault = "The quick brown fox jumps over the lazy dog"

    static var page: Page {
        Page(
            id: "page-anatomy",
            title: "Page anatomy",
            section: .foundations,
            component: ComponentPage(
                variants: [
                    ComponentVariant(name: "Short") { Text("Label") },
                    ComponentVariant(name: "Long") {
                        Text(
                            "A longer subject wraps across several lines, so the page shows how it behaves when its "
                                + "content needs more room than one line gives. The text keeps its leading alignment "
                                + "and line spacing, and the row grows to fit every line it takes."
                        )
                    }
                ],
                properties: [
                    ComponentProperty(name: "sampleText", type: "String", defaultValue: sampleTextDefault)
                ],
                tokens: [],
                playgroundIntro: "Playground: the live subject, a control for each property and data field, "
                    + "the shared environment and the code it takes.",
                variantsIntro: "Variants: every variant, in light and dark.",
                configurationIntro: "Configuration: properties with their defaults, "
                    + "component tokens with their alias chains.",
                playground: { PageAnatomyPage() }
            )
        )
    }

    @State private var sampleText = sampleTextDefault

    var body: some View {
        PlaygroundLayout(snippet: "Text(\"\(escaped)\")") {
            Text(sampleText)
        } controls: {
            TextField("Sample text", text: $sampleText)
        }
    }

    private var escaped: String {
        sampleText
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }
}
