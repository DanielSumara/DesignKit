extension DS.Theme.Inventory {
    static func primitiveEntries() -> [PrimitiveEntry] {
        entries(DS.Theme.ColorPrimitive.self) { primitive in
            switch primitive.value {
            case .srgb(let hex): .srgb(hex: hex)
            case .system: .system
            }
        }
        + entries(DS.Theme.SpacePrimitive.self) { .points($0.points) }
        + entries(DS.Theme.SizePrimitive.self) { .points($0.points) }
        + entries(DS.Theme.RadiusPrimitive.self) { .points($0.points) }
        + entries(DS.Theme.StrokePrimitive.self) { .points($0.points) }
        + entries(DS.Theme.DurationPrimitive.self) { .milliseconds($0.milliseconds) }
        + entries(DS.Theme.OpacityPrimitive.self) { .percent($0.percent) }
        + entries(DS.Theme.FontSizePrimitive.self) { .points($0.points) }
    }

    private static func entries<P: DS.Theme.Primitive>(_ type: P.Type, value: (P) -> PrimitiveValue) -> [PrimitiveEntry] {
        P.all.map { PrimitiveEntry(scale: P.scale, name: $0.name, value: value($0)) }
    }
}
