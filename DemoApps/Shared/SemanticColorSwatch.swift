@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticColorSwatch: View {
    enum Kind: CaseIterable {
        case light
        case dark
        case lightIncreased
        case darkIncreased
        case current

        var title: String {
            switch self {
            case .light: "Light"
            case .dark: "Dark"
            case .lightIncreased: "Light increased"
            case .darkIncreased: "Dark increased"
            case .current: "Current"
            }
        }
    }

    let token: SemanticColorToken
    let kind: Kind

    var body: some View {
        SwatchSquare { fill }
            .accessibilityLabel("\(token.name) \(kind.title)")
    }

    @ViewBuilder
    private var fill: some View {
        switch kind {
        case .light: Color(mds: token.path).environment(\.colorScheme, .light)
        case .dark: Color(mds: token.path).environment(\.colorScheme, .dark)
        case .lightIncreased: Color(inventory: token.lightIncreased)
        case .darkIncreased: Color(inventory: token.darkIncreased)
        case .current: Color(mds: token.path)
        }
    }
}
