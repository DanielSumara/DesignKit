import DesignSystem
import SwiftUI

internal struct SemanticColorStack: View {
    @MDS private var mds
    let tokens: [SemanticColorToken]

    var body: some View {
        VStack(alignment: .leading, spacing: mds(spacing: \.medium)) {
            ForEach(tokens) { token in
                VStack(alignment: .leading, spacing: mds(spacing: \.xxSmall)) {
                    Text(token.name)
                        .font(mds: \.body)
                    Text(token.aliasText)
                        .font(mds: \.caption)
                        .foregroundStyle(mds: \.secondary)
                    Text("Increase Contrast: \(token.increaseContrastText ?? "same")")
                        .font(mds: \.caption)
                        .foregroundStyle(mds: \.secondary)
                    WrappingLayout(spacing: mds(spacing: \.medium)) {
                        ForEach(SemanticColorSwatch.Kind.allCases, id: \.self) { kind in
                            SemanticColorSwatch(token: token, kind: kind, showsTitle: true)
                        }
                    }
                }
            }
        }
    }
}
