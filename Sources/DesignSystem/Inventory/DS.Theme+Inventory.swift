extension DS.Theme {
    @_spi(Showcase) public struct Inventory: Equatable, Sendable {
        public let primitives: [PrimitiveEntry]
        public let semanticTokens: [SemanticEntry]
        public let componentTokens: [ComponentEntry]
    }

    @_spi(Showcase) public var inventory: Inventory {
        Inventory(
            primitives: Inventory.primitiveEntries(),
            semanticTokens: Inventory.semanticEntries(of: semanticTokens),
            componentTokens: Inventory.componentEntries(of: components)
        )
    }
}
