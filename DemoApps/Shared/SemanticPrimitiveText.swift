@_spi(Showcase) import DesignSystem
import Foundation

internal enum SemanticPrimitiveText {
    static func text(of entry: DS.Theme.Inventory.SemanticEntry, in inventory: DS.Theme.Inventory) -> String {
        switch entry.value {
        case .primitive(let scale, let name):
            guard let primitive = inventory.primitives.first(where: { $0.scale == scale && $0.name == name }) else {
                return name
            }
            return "\(name) · \(valueText(of: primitive.value))"
        case .design(let design):
            return design
        case .color:
            return ""
        }
    }

    private static func valueText(of value: DS.Theme.Inventory.PrimitiveValue) -> String {
        switch value {
        case .points(let points): "\(points.formatted(.number.locale(Locale(identifier: "en")))) pt"
        case .milliseconds(let milliseconds): "\(milliseconds) ms"
        case .percent(let percent): "\(percent) %"
        case .srgb, .system: ""
        }
    }
}
