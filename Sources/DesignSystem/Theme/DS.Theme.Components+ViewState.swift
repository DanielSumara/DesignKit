extension DS.Theme.Components {
    public struct ViewState: Equatable, Sendable {
        public internal(set) var activityIndicatorDelay: Delay
        public internal(set) var labelSpacing: Spacing

        mutating func resolve(against semanticTokens: DS.Theme.SemanticTokens) {
            let token = activityIndicatorDelay.token
            activityIndicatorDelay.resolvedDuration = .milliseconds(semanticTokens.motion[keyPath: token].primitive.milliseconds)
            labelSpacing.resolve(against: semanticTokens)
        }
    }
}
