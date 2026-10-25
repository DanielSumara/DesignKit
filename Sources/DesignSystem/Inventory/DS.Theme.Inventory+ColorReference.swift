extension DS.Theme.Inventory {
    @_spi(Showcase) public struct ColorReference: Equatable, Sendable {
        public let color: String
        public let opacity: String?
    }
}
