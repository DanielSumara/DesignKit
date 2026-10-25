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

    @MDS private var mds
    let token: SemanticColorToken
    let kind: Kind
    var showsTitle = false

    var body: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
            swatch
            if showsTitle {
                Text(kind.title)
                    .font(mds: \.caption)
                    .foregroundStyle(mds: \.secondary)
            }
        }
    }

    private var swatch: some View {
        fill
            .frame(width: mds(spacing: \.xLarge), height: mds(spacing: \.xLarge))
            .clipShape(mds: \.small)
            .border(mds: \.subtle, width: \.thin, cornerRadius: \.small)
            .accessibilityLabel(kind.title)
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
