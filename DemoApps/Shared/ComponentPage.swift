import SwiftUI

internal struct ComponentPage {
    let playground: @MainActor () -> AnyView
    let variants: [ComponentVariant]
    let properties: [ComponentProperty]
    let tokens: [ComponentToken]
    let playgroundIntro: String?
    let variantsIntro: String?
    let configurationIntro: String?

    init<Playground: View>(
        variants: [ComponentVariant] = [],
        properties: [ComponentProperty] = [],
        tokens: [ComponentToken] = [],
        playgroundIntro: String? = nil,
        variantsIntro: String? = nil,
        configurationIntro: String? = nil,
        @ViewBuilder playground: @escaping @MainActor () -> Playground
    ) {
        self.playground = { AnyView(playground()) }
        self.variants = variants
        self.properties = properties
        self.tokens = tokens
        self.playgroundIntro = playgroundIntro
        self.variantsIntro = variantsIntro
        self.configurationIntro = configurationIntro
    }
}
