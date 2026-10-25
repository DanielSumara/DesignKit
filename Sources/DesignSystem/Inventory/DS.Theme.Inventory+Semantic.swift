import DesignKit

extension DS.Theme.Inventory {
    typealias Tokens = DS.Theme.SemanticTokens

    static func semanticEntries(of tokens: Tokens) -> [SemanticEntry] {
        let stored = Set(Mirror(reflecting: tokens).children.compactMap(\.label))
        let known: Set<String> = ["colors", "spacing", "typography", "radius", "borderWidth", "motion"]
        precondition(stored == known, "Unmapped token groups \(stored.symmetricDifference(known))")
        let colors = Mirror(reflecting: tokens.colors).children.flatMap { group in
            entries(of: group.value, kind: .color, group: group.label)
        }
        return colors
            + entries(of: tokens.spacing, kind: .spacing, group: "spacing")
            + entries(of: tokens.radius, kind: .radius, group: "radius")
            + entries(of: tokens.borderWidth, kind: .borderWidth, group: "borderWidth")
            + entries(of: tokens.motion, kind: .motion, group: "motion")
            + entries(of: tokens.typography, kind: .typography, group: "typography")
    }

    private static func entries(of group: Any, kind: SemanticKind, group label: String?) -> [SemanticEntry] {
        guard let label else { preconditionFailure("Unlabeled token group") }
        let title = label.prefix(1).uppercased() + label.dropFirst()
        return Mirror(reflecting: group).children.map { child in
            guard let name = child.label else { preconditionFailure("Unlabeled token in \(title)") }
            return SemanticEntry(kind: kind, group: title, name: name, value: semanticValue(of: child.value))
        }
    }

    private static func semanticValue(of value: Any) -> SemanticValue {
        switch value {
        case let color as DS.Theme.AdaptiveColor:
            .color(color.inventoryAlias)
        case let value as Tokens.Spacing.Value:
            .primitive(scale: DK.SpacePrimitive.scale, name: value.primitive.name)
        case let value as Tokens.Radius.Value:
            .primitive(scale: DK.RadiusPrimitive.scale, name: value.primitive.name)
        case let value as Tokens.BorderWidth.Value:
            .primitive(scale: DK.StrokePrimitive.scale, name: value.primitive.name)
        case let value as Tokens.Motion.Value:
            .primitive(scale: DK.DurationPrimitive.scale, name: value.primitive.name)
        case let primitive as DK.FontSizePrimitive:
            .primitive(scale: DK.FontSizePrimitive.scale, name: primitive.name)
        case let design as Tokens.Typography.Design:
            .design(String(describing: design))
        default:
            preconditionFailure("Unmapped token type \(type(of: value))")
        }
    }
}

extension DS.Theme.Inventory.ColorReference {
    init(_ alias: DS.Theme.AdaptiveColor.Alias) {
        self.init(color: alias.color.name, opacity: alias.opacity?.name)
    }
}
