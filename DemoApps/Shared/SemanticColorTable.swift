import DesignSystem
import SwiftUI

internal struct SemanticColorTable: View {
    @MDS private var mds
    let tokens: [SemanticColorToken]

    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: mds(spacing: \.large), verticalSpacing: mds(spacing: \.small)) {
            GridRow {
                Text("Token")
                Text("Alias")
                Text("Increase Contrast")
                ForEach(SemanticColorSwatch.Kind.allCases, id: \.self) { kind in
                    Text(kind.title)
                }
            }
            .font(mds: \.caption)
            .foregroundStyle(mds: \.secondary)
            ForEach(tokens) { token in
                GridRow {
                    Text(token.name)
                    Text(token.aliasText)
                        .foregroundStyle(mds: \.secondary)
                    Text(token.increaseContrastText ?? "same")
                        .foregroundStyle(mds: \.secondary)
                    ForEach(SemanticColorSwatch.Kind.allCases, id: \.self) { kind in
                        SemanticColorSwatch(token: token, kind: kind)
                    }
                }
                .font(mds: \.body)
            }
        }
    }
}
