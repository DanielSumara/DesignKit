extension DS.Theme.Inventory {
    @_spi(Showcase) public struct ComponentEntry: Equatable, Sendable {
        public let component: String
        public let name: String
        public let aliasedName: String
    }
}
