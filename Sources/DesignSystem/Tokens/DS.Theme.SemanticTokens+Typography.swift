import SwiftUI

extension DS.Theme.SemanticTokens {
    public struct Typography: Equatable, Sendable {
        var design: Design
        var largeTitle: DS.Theme.FontSizePrimitive
        var title: DS.Theme.FontSizePrimitive
        var title2: DS.Theme.FontSizePrimitive
        var title3: DS.Theme.FontSizePrimitive
        var headline: DS.Theme.FontSizePrimitive
        var subheadline: DS.Theme.FontSizePrimitive
        var body: DS.Theme.FontSizePrimitive
        var callout: DS.Theme.FontSizePrimitive
        var footnote: DS.Theme.FontSizePrimitive
        var caption: DS.Theme.FontSizePrimitive
        var caption2: DS.Theme.FontSizePrimitive

        private static let sizePaths: [Font.TextStyle: KeyPath<Typography, DS.Theme.FontSizePrimitive> & Sendable] = [
            .largeTitle: \.largeTitle,
            .title: \.title,
            .title2: \.title2,
            .title3: \.title3,
            .headline: \.headline,
            .subheadline: \.subheadline,
            .callout: \.callout,
            .footnote: \.footnote,
            .caption: \.caption,
            .caption2: \.caption2,
        ]

        func fontSize(of style: Font.TextStyle) -> DS.Theme.FontSizePrimitive {
            self[keyPath: Self.sizePaths[style] ?? \.body]
        }
    }
}

extension DS.Theme.SemanticTokens.Typography {
    public enum Design: Equatable, Sendable {
        case `default`
        case rounded
        case serif
        case monospaced

        var fontDesign: Font.Design {
            switch self {
            case .default: .default
            case .rounded: .rounded
            case .serif: .serif
            case .monospaced: .monospaced
            }
        }
    }

    public struct Style: Sendable {
        public var largeTitle: Font.TextStyle { .largeTitle }
        public var title: Font.TextStyle { .title }
        public var title2: Font.TextStyle { .title2 }
        public var title3: Font.TextStyle { .title3 }
        public var headline: Font.TextStyle { .headline }
        public var subheadline: Font.TextStyle { .subheadline }
        public var body: Font.TextStyle { .body }
        public var callout: Font.TextStyle { .callout }
        public var footnote: Font.TextStyle { .footnote }
        public var caption: Font.TextStyle { .caption }
        public var caption2: Font.TextStyle { .caption2 }
    }

    public struct Weight: Sendable {
        public var regular: Font.Weight { .regular }
        public var medium: Font.Weight { .medium }
        public var semibold: Font.Weight { .semibold }
        public var bold: Font.Weight { .bold }
    }
}

extension Font.TextStyle {
    var baseWeight: Font.Weight {
        switch self {
        case .headline: .bold
        case .caption2: .medium
        default: .regular
        }
    }
}
