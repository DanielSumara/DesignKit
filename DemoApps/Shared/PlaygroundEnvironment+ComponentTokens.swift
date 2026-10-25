@_spi(Showcase) import DesignSystem

extension PlaygroundEnvironment {
    func componentTokens(of component: String) -> [ComponentToken] {
        resolvedTheme.inventory.componentTokens
            .filter { $0.component == component }
            .map { ComponentToken(token: $0.name, aliasChain: [$0.aliasedName]) }
    }
}
