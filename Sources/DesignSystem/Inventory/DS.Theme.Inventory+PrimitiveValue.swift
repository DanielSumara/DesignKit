extension DS.Theme.Inventory {
    @_spi(Showcase) public enum PrimitiveValue: Equatable, Sendable {
        case srgb(hex: UInt32)
        case system
        case points(Double)
        case milliseconds(Int)
        case percent(Int)
    }
}
