@_spi(Showcase) import DesignSystem

internal enum SemanticPrimitiveText {
    static func text(of entry: DS.Theme.Inventory.SemanticEntry, in inventory: DS.Theme.Inventory) -> String {
        switch entry.value {
        case .primitive(let scale, let name):
            guard let primitive = inventory.primitives.first(where: { $0.scale == scale && $0.name == name }) else {
                return name
            }
            return "\(name) · \(PrimitiveValueText.text(of: primitive.value))"
        case .design(let design):
            return design
        case .color:
            return ""
        }
    }
}
