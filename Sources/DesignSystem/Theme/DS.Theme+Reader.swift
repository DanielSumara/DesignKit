import DesignKit
import SwiftUI

extension DS.Theme {
    public struct Reader {
        let theme: DS.Theme
        let textSize: DK.TextSize
        let bodyScale: CGFloat
        let reducesMotion: Bool

        var components: Components {
            theme.components.resolved(against: theme.semanticTokens).scaled(by: textScale)
        }

        private var textScale: CGFloat {
            #if os(macOS)
            textSize.scale
            #else
            bodyScale
            #endif
        }

        public func callAsFunction(color token: KeyPath<SemanticTokens.Colors, AdaptiveColor> & Sendable) -> Color {
            Color(mds: token)
        }

        public func callAsFunction(spacing token: KeyPath<SemanticTokens.Spacing, SemanticTokens.Spacing.Value>) -> CGFloat {
            CGFloat(theme.semanticTokens.spacing[keyPath: token].primitive.points)
        }

        public func callAsFunction(radius token: KeyPath<SemanticTokens.Radius, SemanticTokens.Radius.Value>) -> CGFloat {
            CGFloat(theme.semanticTokens.radius[keyPath: token].primitive.points)
        }

        public func callAsFunction(
            borderWidth token: KeyPath<SemanticTokens.BorderWidth, SemanticTokens.BorderWidth.Value>
        ) -> CGFloat {
            CGFloat(theme.semanticTokens.borderWidth[keyPath: token].primitive.points)
        }

        public func callAsFunction(
            font weight: KeyPath<SemanticTokens.Typography.Weight, Font.Weight>,
            _ style: KeyPath<SemanticTokens.Typography.Style, Font.TextStyle>
        ) -> Font {
            font(style, weight: SemanticTokens.Typography.Weight()[keyPath: weight])
        }

        public func callAsFunction(font style: KeyPath<SemanticTokens.Typography.Style, Font.TextStyle>) -> Font {
            font(style, weight: nil)
        }

        public func callAsFunction(motion token: KeyPath<SemanticTokens.Motion, SemanticTokens.Motion.Value>) -> Animation? {
            guard !reducesMotion else { return nil }
            return .easeInOut(duration: theme.semanticTokens.motion[keyPath: token].primitive.seconds)
        }

        private func font(_ style: KeyPath<SemanticTokens.Typography.Style, Font.TextStyle>, weight: Font.Weight?) -> Font {
            let textStyle = SemanticTokens.Typography.Style()[keyPath: style]
            let design = theme.semanticTokens.typography.design.fontDesign
            #if os(macOS)
            return .system(
                size: theme.semanticTokens.typography.fontSize(of: textStyle).points * textSize.scale,
                weight: weight ?? textStyle.baseWeight,
                design: design
            )
            #else
            return .system(textStyle, design: design, weight: weight)
            #endif
        }
    }
}
