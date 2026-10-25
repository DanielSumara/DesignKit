import SwiftUI

extension Color {
    @_spi(Showcase) public init(inventory entry: DS.Theme.Inventory.PrimitiveEntry) {
        guard entry.scale == DS.Theme.ColorPrimitive.scale else {
            preconditionFailure("Not a color primitive \(entry.scale).\(entry.name)")
        }
        switch entry.value {
        case .srgb(let hex):
            self.init(
                .sRGB,
                red: Double(hex >> 16 & 0xFF) / 255,
                green: Double(hex >> 8 & 0xFF) / 255,
                blue: Double(hex & 0xFF) / 255
            )
        case .system:
            self = .accent
        default:
            preconditionFailure("Not a color value \(entry.name)")
        }
    }

    @_spi(Showcase) public init(inventory reference: DS.Theme.Inventory.ColorReference) {
        guard let primitive = DS.Theme.ColorPrimitive.all.first(where: { $0.name == reference.color }) else {
            preconditionFailure("Unknown color primitive \(reference.color)")
        }
        let value: DS.Theme.Inventory.PrimitiveValue
        switch primitive.value {
        case .srgb(let hex):
            value = .srgb(hex: hex)
        case .system:
            value = .system
        }
        self.init(
            inventory: DS.Theme.Inventory.PrimitiveEntry(
                scale: DS.Theme.ColorPrimitive.scale,
                name: primitive.name,
                value: value
            )
        )
        guard let opacityName = reference.opacity else { return }
        guard let opacity = DS.Theme.OpacityPrimitive.all.first(where: { $0.name == opacityName }) else {
            preconditionFailure("Unknown opacity primitive \(opacityName)")
        }
        self = self.opacity(opacity.fraction)
    }

    @_spi(Showcase) public static var accent: Color { .accentColor }
}
