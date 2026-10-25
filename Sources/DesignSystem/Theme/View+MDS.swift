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

    public func foregroundStyle(
        mds token: KeyPath<DS.Theme.SemanticTokens.Colors.Foreground, DS.Theme.AdaptiveColor> & Sendable
    ) -> some View {
        foregroundStyle(DS.Theme.TokenColor(group: \.foreground, token: token))
    }

    public func foregroundStyle(
        mds token: KeyPath<DS.Theme.SemanticTokens.Colors.ForegroundOnBackground, DS.Theme.AdaptiveColor> & Sendable
    ) -> some View {
        foregroundStyle(DS.Theme.TokenColor(group: \.foregroundOnBackground, token: token))
    }

    public func background(
        mds token: KeyPath<DS.Theme.SemanticTokens.Colors.Background, DS.Theme.AdaptiveColor> & Sendable
    ) -> some View {
        background(DS.Theme.TokenColor(group: \.background, token: token))
    }

    public func background(
        mds token: KeyPath<DS.Theme.SemanticTokens.Colors.Background, DS.Theme.AdaptiveColor> & Sendable,
        cornerRadius radius: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>
    ) -> some View {
        modifier(RoundedBackgroundModifier(token: token, radius: radius))
    }

    public func border(
        mds token: KeyPath<DS.Theme.SemanticTokens.Colors.Border, DS.Theme.AdaptiveColor> & Sendable,
        width: KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value>,
        cornerRadius radius: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>
    ) -> some View {
        modifier(BorderModifier(token: token, width: width, radius: radius))
    }

    public func clipShape(mds radius: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>) -> some View {
        modifier(ClipShapeModifier(radius: radius))
    }

    public func tint(
        mds token: KeyPath<DS.Theme.SemanticTokens.Colors.Background, DS.Theme.AdaptiveColor> & Sendable
    ) -> some View {
        resolvedTint(DS.Theme.TokenColor(group: \.background, token: token).resolve(in:))
    }

    public func padding(mds spacing: KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value>) -> some View {
        padding(.all, mds: spacing)
    }

    public func padding(_ edges: Edge.Set, mds spacing: KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value>) -> some View {
        modifier(PaddingModifier(edges: edges, spacing: spacing))
    }

    public func animation(mds motion: KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value>, value: some Equatable) -> some View {
        modifier(AnimationModifier(motion: motion, value: value))
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
