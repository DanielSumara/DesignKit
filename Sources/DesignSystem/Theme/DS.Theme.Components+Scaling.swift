import Foundation

extension DS.Theme.Components {
    func scaled(by scale: CGFloat) -> Self {
        var components = self
        components.activityIndicator.largePlaceholderSize.factor = scale
        components.activityIndicator.extraLargePlaceholderSize.factor = scale
        components.inlineAlert.iconSize.factor = scale
        components.edgeCase.iconSize.factor = scale
        components.modalSheet.standardWidth.factor = scale
        components.modalSheet.wideWidth.factor = scale
        components.modalSheet.maxHeight.factor = scale
        return components
    }

    func resolved(against semanticTokens: DS.Theme.SemanticTokens) -> Self {
        var components = self
        let motion = semanticTokens.motion
        let token = components.actionButton.activityIndicatorDelay.token
        components.actionButton.activityIndicatorDelay.resolvedDuration = .milliseconds(motion[keyPath: token].primitive.milliseconds)
        components.inlineAlert.resolve(against: semanticTokens)
        components.edgeCase.resolve(against: semanticTokens)
        components.fieldRow.resolve(against: semanticTokens)
        components.modalSheet.resolve(against: semanticTokens)
        return components
    }
}
