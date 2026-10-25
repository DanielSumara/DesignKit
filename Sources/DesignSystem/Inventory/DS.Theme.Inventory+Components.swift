import DesignKit

extension DS.Theme.Inventory {
    static func componentEntries(of components: DS.Theme.Components, semanticTokens: Tokens) -> [ComponentEntry] {
        let semantic = semanticEntries(of: semanticTokens)
        return activityIndicatorEntries(of: components.activityIndicator)
            + actionButtonEntries(of: components.actionButton, semantic: semantic)
            + statusIconEntries(of: components.statusIcon, semantic: semantic)
            + inlineAlertEntries(of: components.inlineAlert, semantic: semantic)
            + edgeCaseEntries(of: components.edgeCase, semantic: semantic)
    }

    private static func activityIndicatorEntries(of configuration: DS.Theme.Components.ActivityIndicator) -> [ComponentEntry] {
        [
            ComponentEntry(
                component: "activityIndicator",
                name: "largePlaceholderSize",
                aliasedName: configuration.largePlaceholderSize.primitive.name
            ),
            ComponentEntry(
                component: "activityIndicator",
                name: "extraLargePlaceholderSize",
                aliasedName: configuration.extraLargePlaceholderSize.primitive.name
            ),
        ]
    }

    private static func actionButtonEntries(
        of configuration: DS.Theme.Components.ActionButton,
        semantic: [SemanticEntry]
    ) -> [ComponentEntry] {
        let token = configuration.activityIndicatorDelay.token
        let entry = semantic.first { entry in
            guard entry.kind == .motion, case .motion(let path) = entry.path else { return false }
            return path == token
        }
        return [
            ComponentEntry(
                component: "actionButton",
                name: "activityIndicatorDelay",
                aliasedName: chain(of: entry)
            ),
        ]
    }

    private static func statusIconEntries(
        of configuration: DS.Theme.Components.StatusColors,
        semantic: [SemanticEntry]
    ) -> [ComponentEntry] {
        DK.Status.allCases.map { status in
            let token = configuration.token(of: status)
            let entry = semantic.first { entry in
                guard entry.kind == .color, case .color(let path) = entry.path else { return false }
                return path == token
            }
            return ComponentEntry(component: "statusIcon", name: "color(\(status))", aliasedName: chain(of: entry))
        }
    }

    private static func inlineAlertEntries(
        of configuration: DS.Theme.Components.InlineAlert,
        semantic: [SemanticEntry]
    ) -> [ComponentEntry] {
        let background = DK.Status.allCases.map { status in
            ComponentEntry(
                component: "inlineAlert",
                name: "background(\(status))",
                aliasedName: chain(of: colorEntry(configuration.background.token(of: status), in: semantic))
            )
        }
        let border = DK.Status.allCases.map { status in
            ComponentEntry(
                component: "inlineAlert",
                name: "border(\(status))",
                aliasedName: chain(of: colorEntry(configuration.border.token(of: status), in: semantic))
            )
        }
        return background + border + [
            ComponentEntry(
                component: "inlineAlert",
                name: "borderWidth",
                aliasedName: chain(of: borderWidthEntry(configuration.borderWidth.token, in: semantic))
            ),
            ComponentEntry(
                component: "inlineAlert",
                name: "radius",
                aliasedName: chain(of: radiusEntry(configuration.radius.token, in: semantic))
            ),
            ComponentEntry(
                component: "inlineAlert",
                name: "padding",
                aliasedName: chain(of: spacingEntry(configuration.padding.token, in: semantic))
            ),
            ComponentEntry(component: "inlineAlert", name: "iconSize", aliasedName: configuration.iconSize.primitive.name),
            ComponentEntry(
                component: "inlineAlert",
                name: "iconSpacing",
                aliasedName: chain(of: spacingEntry(configuration.iconSpacing.token, in: semantic))
            ),
            ComponentEntry(
                component: "inlineAlert",
                name: "noticeSpacing",
                aliasedName: chain(of: spacingEntry(configuration.noticeSpacing.token, in: semantic))
            ),
            ComponentEntry(
                component: "inlineAlert",
                name: "titleSpacing",
                aliasedName: chain(of: spacingEntry(configuration.titleSpacing.token, in: semantic))
            ),
        ]
    }

    private static func edgeCaseEntries(
        of configuration: DS.Theme.Components.EdgeCase,
        semantic: [SemanticEntry]
    ) -> [ComponentEntry] {
        [
            ComponentEntry(component: "edgeCase", name: "iconSize", aliasedName: configuration.iconSize.primitive.name),
            ComponentEntry(
                component: "edgeCase",
                name: "imageRadius",
                aliasedName: chain(of: radiusEntry(configuration.imageRadius.token, in: semantic))
            ),
        ]
    }

    private static func colorEntry(
        _ token: DS.Theme.Components.StatusColors.ColorToken,
        in semantic: [SemanticEntry]
    ) -> SemanticEntry? {
        semantic.first { entry in
            guard entry.kind == .color, case .color(let path) = entry.path else { return false }
            return path == token
        }
    }

    private static func spacingEntry(_ token: DS.Theme.Components.Spacing.Token, in semantic: [SemanticEntry]) -> SemanticEntry? {
        semantic.first { entry in
            guard entry.kind == .spacing, case .spacing(let path) = entry.path else { return false }
            return path == token
        }
    }

    private static func radiusEntry(_ token: DS.Theme.Components.Radius.Token, in semantic: [SemanticEntry]) -> SemanticEntry? {
        semantic.first { entry in
            guard entry.kind == .radius, case .radius(let path) = entry.path else { return false }
            return path == token
        }
    }

    private static func borderWidthEntry(
        _ token: DS.Theme.Components.BorderWidth.Token,
        in semantic: [SemanticEntry]
    ) -> SemanticEntry? {
        semantic.first { entry in
            guard entry.kind == .borderWidth, case .borderWidth(let path) = entry.path else { return false }
            return path == token
        }
    }

    private static func chain(of entry: SemanticEntry?) -> String {
        guard let entry else { preconditionFailure("Component token aliases an unmapped semantic token") }
        let name = "\(entry.group).\(entry.name)"
        switch entry.value {
        case .primitive(_, let primitive):
            return "\(name) → \(primitive)"
        case .color(let alias):
            return "\(name) → \(colorChain(of: alias))"
        case .design(let design):
            return "\(name) → \(design)"
        }
    }

    private static func colorChain(of alias: ColorAlias) -> String {
        let normal = "\(describe(alias.light)) · \(describe(alias.dark))"
        guard alias.increasedLight != nil || alias.increasedDark != nil else { return normal }
        let increasedLight = describe(alias.increasedLight ?? alias.light)
        let increasedDark = describe(alias.increasedDark ?? alias.dark)
        return "\(normal) (increased \(increasedLight) · \(increasedDark))"
    }

    private static func describe(_ reference: ColorReference) -> String {
        guard let opacity = reference.opacity else { return reference.color }
        return "\(reference.color) @ \(opacity)"
    }
}
