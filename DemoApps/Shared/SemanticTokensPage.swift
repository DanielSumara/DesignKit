import DesignSystem
import SwiftUI

@MainActor
internal struct SemanticTokensPage: Page {
    let id = "semantic-tokens"
    let title = "Semantic tokens"
    let section = Section.foundations

    var content: some View {
        SemanticTokensView()
            .navigationTitle(title)
    }
}

private extension SemanticTokensPage {
    static let intro = "Each value aliases a primitive: colors as a light and dark pair with an optional "
        + "Increase Contrast pair, the rest one primitive."

    struct SemanticTokensView: View {
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    EnvironmentControls(showsAppearance: false)
                    SectionsView()
                        .showcaseEnvironment()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    struct SectionsView: View {
        @MDS private var mds

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.large)) {
                Text(SemanticTokensPage.intro)
                    .font(mds: \.body)
                    .foregroundStyle(mds: \.secondary)
                SemanticColorsSection()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
