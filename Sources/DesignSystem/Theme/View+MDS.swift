import SwiftUI

extension View {
    public func font(
        mds weight: KeyPath<DS.Theme.SemanticTokens.Typography.Weight, Font.Weight>,
        _ style: KeyPath<DS.Theme.SemanticTokens.Typography.Style, Font.TextStyle>
    ) -> some View {
        modifier(TypographyModifier(weight: weight, style: style))
    }

    public func font(mds style: KeyPath<DS.Theme.SemanticTokens.Typography.Style, Font.TextStyle>) -> some View {
        modifier(TypographyModifier(weight: nil, style: style))
    }
}

private struct TypographyModifier: ViewModifier {
    @MDS private var mds
    let weight: KeyPath<DS.Theme.SemanticTokens.Typography.Weight, Font.Weight>?
    let style: KeyPath<DS.Theme.SemanticTokens.Typography.Style, Font.TextStyle>

    func body(content: Content) -> some View {
        content.font(weight.map { mds(font: $0, style) } ?? mds(font: style))
    }
}
