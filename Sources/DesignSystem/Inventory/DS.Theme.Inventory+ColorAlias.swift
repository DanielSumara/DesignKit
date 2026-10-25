extension DS.Theme.Inventory {
    @_spi(Showcase) public struct ColorAlias: Equatable, Sendable {
        public let light: ColorReference
        public let dark: ColorReference
        public let increasedLight: ColorReference?
        public let increasedDark: ColorReference?
    }
}
