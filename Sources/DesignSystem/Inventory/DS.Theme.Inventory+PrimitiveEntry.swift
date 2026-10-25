extension DS.Theme.Inventory {
    @_spi(Showcase) public struct PrimitiveEntry: Equatable, Sendable {
        public let scale: String
        public let name: String
        public let value: PrimitiveValue
    }
}
