@_spi(Showcase) import DesignSystem
import SwiftUI

@MainActor
internal struct SemanticTokensPage: Page {
    let id = "semantic-tokens"
    let title = "Semantic tokens"
    let section = Section.foundations

    var content: some View {
        FoundationsPageShell(showsTextSize: true) {
            SectionsView()
        }
        .navigationTitle(title)
    }
}

private extension SemanticTokensPage {
    static let intro = "Each value aliases a primitive: colors as a light and dark pair with an optional "
        + "Increase Contrast pair, the rest one primitive."

    struct SectionsView: View {
        @MDS private var mds

        var body: some View {
            VStack(alignment: .leading, spacing: mds(spacing: \.large)) {
                Text(SemanticTokensPage.intro)
                    .font(mds: \.body)
                    .foregroundStyle(mds: \.secondary)
                SemanticColorsSection()
                SemanticTokenSection(title: "Spacing", kind: .spacing) { entry in
                    if case .spacing(let path) = entry.path {
                        SemanticSpacingSample(name: entry.name, path: path)
                    }
                }
                SemanticTokenSection(title: "Radius", kind: .radius) { entry in
                    if case .radius(let path) = entry.path {
                        SemanticRadiusSample(name: entry.name, path: path)
                    }
                }
                SemanticTokenSection(title: "Border width", kind: .borderWidth) { entry in
                    if case .borderWidth(let path) = entry.path {
                        SemanticBorderWidthSample(name: entry.name, path: path)
                    }
                }
                SemanticTokenSection(title: "Motion", kind: .motion) { entry in
                    if case .motion(let path) = entry.path {
                        SemanticMotionSample(name: entry.name, path: path)
                    }
                }
                SemanticTypographySection()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
