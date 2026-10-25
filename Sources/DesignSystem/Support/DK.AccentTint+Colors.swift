import DesignKit

extension DK.AccentTint {
    typealias BackgroundToken = KeyPath<DS.Theme.SemanticTokens.Colors.Background, DS.Theme.AdaptiveColor> & Sendable
    typealias ForegroundToken = KeyPath<DS.Theme.SemanticTokens.Colors.OnBackground, DS.Theme.AdaptiveColor> & Sendable

    var backgroundToken: BackgroundToken {
        switch self {
        case .brand: \.brandSubtle
        case .info: \.infoSubtle
        case .success: \.successSubtle
        case .warning: \.warningSubtle
        case .critical: \.criticalSubtle
        }
    }

    var foregroundToken: ForegroundToken {
        switch self {
        case .brand: \.brandSubtle
        case .info: \.infoSubtle
        case .success: \.successSubtle
        case .warning: \.warningSubtle
        case .critical: \.criticalSubtle
        }
    }
}
