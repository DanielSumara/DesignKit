import DesignKit

extension DS.Theme.Inventory {
    static func componentEntries(of components: DS.Theme.Components, semanticTokens: Tokens) -> [ComponentEntry] {
        let semantic = semanticEntries(of: semanticTokens)
        return activityIndicatorEntries(of: components.activityIndicator)
            + actionButtonEntries(of: components.actionButton, semantic: semantic)
            + statusIconEntries(of: components.statusIcon, semantic: semantic)
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
        of configuration: DS.Theme.Components.StatusIcon,
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
