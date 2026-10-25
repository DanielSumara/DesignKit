import SwiftUI

extension Color {
    @_spi(Showcase) public init(inventory entry: DS.Theme.Inventory.PrimitiveEntry) {
        guard entry.isColor else {
            preconditionFailure("Not a color primitive \(entry.scale).\(entry.name)")
        }
        guard let primitive = DS.Theme.ColorPrimitive.all.first(where: { $0.name == entry.name }) else {
            preconditionFailure("Unknown color primitive \(entry.name)")
        }
        self.init(primitive)
    }

    @_spi(Showcase) public init(inventory reference: DS.Theme.Inventory.ColorReference) {
        guard let primitive = DS.Theme.ColorPrimitive.all.first(where: { $0.name == reference.color }) else {
            preconditionFailure("Unknown color primitive \(reference.color)")
        }
        guard let opacityName = reference.opacity else {
            self.init(primitive)
            return
        }
        guard let opacity = DS.Theme.OpacityPrimitive.all.first(where: { $0.name == opacityName }) else {
            preconditionFailure("Unknown opacity primitive \(opacityName)")
        }
        self = DS.Theme.AdaptiveColor.Alias(primitive, opacity: opacity).value
    }
}
