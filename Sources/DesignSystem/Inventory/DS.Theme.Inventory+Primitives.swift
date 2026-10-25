import DesignKit

extension DS.Theme.Inventory {
    static func primitiveEntries() -> [PrimitiveEntry] {
        entries(DK.ColorPrimitive.self) { primitive in
            switch primitive.value {
            case .srgb(let hex): .srgb(hex: hex)
            case .system: .system
            }
        }
        + entries(DK.SpacePrimitive.self) { .points($0.points) }
        + entries(DK.SizePrimitive.self) { .points($0.points) }
        + entries(DK.RadiusPrimitive.self) { .points($0.points) }
        + entries(DK.StrokePrimitive.self) { .points($0.points) }
        + entries(DK.DurationPrimitive.self) { .milliseconds($0.milliseconds) }
        + entries(DK.OpacityPrimitive.self) { .percent($0.percent) }
        + entries(DK.FontSizePrimitive.self) { .points($0.points) }
    }

    private static func entries<P: DK.Primitive>(_ type: P.Type, value: (P) -> PrimitiveValue) -> [PrimitiveEntry] {
        P.all.map { PrimitiveEntry(scale: P.scale, name: $0.name, value: value($0)) }
    }
}
