import SwiftUI

extension DS.Theme.Inventory {
    @_spi(Showcase) public enum SemanticPath {
        case color(KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable)
        case spacing(KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value>)
        case radius(KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value>)
        case borderWidth(KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value>)
        case motion(KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value>)
        case typography(KeyPath<DS.Theme.SemanticTokens.Typography.Style, Font.TextStyle>)
        case design
    }
}

extension DS.Theme.Inventory.SemanticEntry {
    @_spi(Showcase) public var path: DS.Theme.Inventory.SemanticPath {
        switch kind {
        case .color:
            .color(DS.Theme.Inventory.colorPath(group: group, name: name))
        case .spacing:
            .spacing(DS.Theme.Inventory.namedPath(DS.Theme.Inventory.spacingPaths, name: name, group: group))
        case .radius:
            .radius(DS.Theme.Inventory.namedPath(DS.Theme.Inventory.radiusPaths, name: name, group: group))
        case .borderWidth:
            .borderWidth(DS.Theme.Inventory.namedPath(DS.Theme.Inventory.borderWidthPaths, name: name, group: group))
        case .motion:
            .motion(DS.Theme.Inventory.namedPath(DS.Theme.Inventory.motionPaths, name: name, group: group))
        case .typography:
            name == "design"
                ? .design
                : .typography(DS.Theme.Inventory.namedPath(DS.Theme.Inventory.typographyPaths, name: name, group: group))
        }
    }
}

private extension DS.Theme.Inventory {
    static let colorPaths: [String: KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable] = [
        "Background.page": \.background.page,
        "Background.surface": \.background.surface,
        "Background.surfaceRaised": \.background.surfaceRaised,
        "Background.brand": \.background.brand,
        "Background.brandSubtle": \.background.brandSubtle,
        "Background.neutral": \.background.neutral,
        "Background.neutralSubtle": \.background.neutralSubtle,
        "Background.info": \.background.info,
        "Background.infoSubtle": \.background.infoSubtle,
        "Background.success": \.background.success,
        "Background.successSubtle": \.background.successSubtle,
        "Background.warning": \.background.warning,
        "Background.warningSubtle": \.background.warningSubtle,
        "Background.critical": \.background.critical,
        "Background.criticalSubtle": \.background.criticalSubtle,
        "OnBackground.brand": \.onBackground.brand,
        "OnBackground.brandSubtle": \.onBackground.brandSubtle,
        "OnBackground.neutral": \.onBackground.neutral,
        "OnBackground.neutralSubtle": \.onBackground.neutralSubtle,
        "OnBackground.info": \.onBackground.info,
        "OnBackground.infoSubtle": \.onBackground.infoSubtle,
        "OnBackground.success": \.onBackground.success,
        "OnBackground.successSubtle": \.onBackground.successSubtle,
        "OnBackground.warning": \.onBackground.warning,
        "OnBackground.warningSubtle": \.onBackground.warningSubtle,
        "OnBackground.critical": \.onBackground.critical,
        "OnBackground.criticalSubtle": \.onBackground.criticalSubtle,
        "Foreground.primary": \.foreground.primary,
        "Foreground.secondary": \.foreground.secondary,
        "Foreground.tertiary": \.foreground.tertiary,
        "Foreground.disabled": \.foreground.disabled,
        "Foreground.brand": \.foreground.brand,
        "Foreground.info": \.foreground.info,
        "Foreground.success": \.foreground.success,
        "Foreground.warning": \.foreground.warning,
        "Foreground.critical": \.foreground.critical,
        "Border.subtle": \.border.subtle,
        "Border.strong": \.border.strong,
        "Border.brand": \.border.brand,
        "Border.info": \.border.info,
        "Border.success": \.border.success,
        "Border.warning": \.border.warning,
        "Border.critical": \.border.critical,
        "Border.criticalSubtle": \.border.criticalSubtle,
        "Focus.ring": \.focus.ring,
    ]

    static let spacingPaths: [String: KeyPath<DS.Theme.SemanticTokens.Spacing, DS.Theme.SemanticTokens.Spacing.Value> & Sendable] = [
        "xxSmall": \.xxSmall,
        "xSmall": \.xSmall,
        "small": \.small,
        "medium": \.medium,
        "large": \.large,
        "xLarge": \.xLarge,
        "xxLarge": \.xxLarge,
    ]

    static let radiusPaths: [String: KeyPath<DS.Theme.SemanticTokens.Radius, DS.Theme.SemanticTokens.Radius.Value> & Sendable] = [
        "small": \.small,
        "medium": \.medium,
        "large": \.large,
        "xLarge": \.xLarge,
    ]

    static let borderWidthPaths: [String: KeyPath<DS.Theme.SemanticTokens.BorderWidth, DS.Theme.SemanticTokens.BorderWidth.Value> & Sendable] = [
        "thin": \.thin,
        "medium": \.medium,
        "thick": \.thick,
    ]

    static let motionPaths: [String: KeyPath<DS.Theme.SemanticTokens.Motion, DS.Theme.SemanticTokens.Motion.Value> & Sendable] = [
        "quick": \.quick,
        "standard": \.standard,
        "slow": \.slow,
    ]

    static let typographyPaths: [String: KeyPath<DS.Theme.SemanticTokens.Typography.Style, Font.TextStyle> & Sendable] = [
        "largeTitle": \.largeTitle,
        "title": \.title,
        "title2": \.title2,
        "title3": \.title3,
        "headline": \.headline,
        "subheadline": \.subheadline,
        "body": \.body,
        "callout": \.callout,
        "footnote": \.footnote,
        "caption": \.caption,
        "caption2": \.caption2,
    ]

    static func colorPath(
        group: String,
        name: String
    ) -> KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable {
        let key = "\(group).\(name)"
        guard let path = colorPaths[key] else {
            preconditionFailure("Unmapped semantic token \(key)")
        }
        return path
    }

    static func namedPath<Root, Value>(
        _ paths: [String: KeyPath<Root, Value> & Sendable],
        name: String,
        group: String
    ) -> KeyPath<Root, Value> & Sendable {
        guard let path = paths[name] else {
            preconditionFailure("Unmapped semantic token \(group).\(name)")
        }
        return path
    }
}
