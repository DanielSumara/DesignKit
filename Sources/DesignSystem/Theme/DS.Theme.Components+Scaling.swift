import Foundation

extension DS.Theme.Components {
    func scaled(by scale: CGFloat) -> Self {
        var components = self
        components.activityIndicator.largePlaceholderSize.factor = scale
        components.activityIndicator.extraLargePlaceholderSize.factor = scale
        components.inlineAlert.iconSize.factor = scale
        components.edgeCase.iconSize.factor = scale
        return components
    }

    func resolved(against semanticTokens: DS.Theme.SemanticTokens) -> Self {
        var components = self
        let motion = semanticTokens.motion
        let token = components.actionButton.activityIndicatorDelay.token
        components.actionButton.activityIndicatorDelay.resolvedDuration = .milliseconds(motion[keyPath: token].primitive.milliseconds)
        components.inlineAlert.resolve(against: semanticTokens)
        components.edgeCase.resolve(against: semanticTokens)
        return components
    }
}
