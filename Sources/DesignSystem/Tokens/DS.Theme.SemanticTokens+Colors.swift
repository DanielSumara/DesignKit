extension DS.Theme.SemanticTokens {
    public struct Colors: Equatable, Sendable {
        public internal(set) var background: Background
        public internal(set) var onBackground: OnBackground
        public internal(set) var foreground: Foreground
        public internal(set) var border: Border
        public internal(set) var focus: Focus

        var foregroundOnBackground: ForegroundOnBackground {
            ForegroundOnBackground(onBackground: onBackground)
        }
    }
}

extension DS.Theme.SemanticTokens.Colors {
    public struct Background: Equatable, Sendable {
        public internal(set) var page: DS.Theme.AdaptiveColor
        public internal(set) var surface: DS.Theme.AdaptiveColor
        public internal(set) var surfaceRaised: DS.Theme.AdaptiveColor
        public internal(set) var brand: DS.Theme.AdaptiveColor
        public internal(set) var brandSubtle: DS.Theme.AdaptiveColor
        public internal(set) var neutral: DS.Theme.AdaptiveColor
        public internal(set) var neutralSubtle: DS.Theme.AdaptiveColor
        public internal(set) var info: DS.Theme.AdaptiveColor
        public internal(set) var infoSubtle: DS.Theme.AdaptiveColor
        public internal(set) var success: DS.Theme.AdaptiveColor
        public internal(set) var successSubtle: DS.Theme.AdaptiveColor
        public internal(set) var warning: DS.Theme.AdaptiveColor
        public internal(set) var warningSubtle: DS.Theme.AdaptiveColor
        public internal(set) var critical: DS.Theme.AdaptiveColor
        public internal(set) var criticalSubtle: DS.Theme.AdaptiveColor
    }

    public struct OnBackground: Equatable, Sendable {
        public internal(set) var brand: DS.Theme.AdaptiveColor
        public internal(set) var brandSubtle: DS.Theme.AdaptiveColor
        public internal(set) var neutral: DS.Theme.AdaptiveColor
        public internal(set) var neutralSubtle: DS.Theme.AdaptiveColor
        public internal(set) var info: DS.Theme.AdaptiveColor
        public internal(set) var infoSubtle: DS.Theme.AdaptiveColor
        public internal(set) var success: DS.Theme.AdaptiveColor
        public internal(set) var successSubtle: DS.Theme.AdaptiveColor
        public internal(set) var warning: DS.Theme.AdaptiveColor
        public internal(set) var warningSubtle: DS.Theme.AdaptiveColor
        public internal(set) var critical: DS.Theme.AdaptiveColor
        public internal(set) var criticalSubtle: DS.Theme.AdaptiveColor
    }

    public struct Foreground: Equatable, Sendable {
        public internal(set) var primary: DS.Theme.AdaptiveColor
        public internal(set) var secondary: DS.Theme.AdaptiveColor
        public internal(set) var tertiary: DS.Theme.AdaptiveColor
        public internal(set) var disabled: DS.Theme.AdaptiveColor
        public internal(set) var brand: DS.Theme.AdaptiveColor
        public internal(set) var info: DS.Theme.AdaptiveColor
        public internal(set) var success: DS.Theme.AdaptiveColor
        public internal(set) var warning: DS.Theme.AdaptiveColor
        public internal(set) var critical: DS.Theme.AdaptiveColor
    }

    public struct Border: Equatable, Sendable {
        public internal(set) var subtle: DS.Theme.AdaptiveColor
        public internal(set) var strong: DS.Theme.AdaptiveColor
        public internal(set) var brand: DS.Theme.AdaptiveColor
        public internal(set) var info: DS.Theme.AdaptiveColor
        public internal(set) var success: DS.Theme.AdaptiveColor
        public internal(set) var warning: DS.Theme.AdaptiveColor
        public internal(set) var critical: DS.Theme.AdaptiveColor
        public internal(set) var criticalSubtle: DS.Theme.AdaptiveColor
    }

    public struct Focus: Equatable, Sendable {
        public internal(set) var ring: DS.Theme.AdaptiveColor
    }

    public struct ForegroundOnBackground: Sendable {
        public let onBackground: OnBackground
    }
}
