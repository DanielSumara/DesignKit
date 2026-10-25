@_spi(Showcase) import DesignSystem
import SwiftUI

internal struct SemanticColorToken: Identifiable {
    let name: String
    let path: KeyPath<DS.Theme.SemanticTokens.Colors, DS.Theme.AdaptiveColor> & Sendable
    let alias: DS.Theme.Inventory.ColorAlias

    var id: String { name }

    var aliasText: String {
        "\(Self.text(of: alias.light)) · \(Self.text(of: alias.dark))"
    }

    var increaseContrastText: String? {
        guard alias.increasedLight != nil || alias.increasedDark != nil else { return nil }
        return "\(Self.text(of: lightIncreased)) · \(Self.text(of: darkIncreased))"
    }

    var lightIncreased: DS.Theme.Inventory.ColorReference {
        alias.increasedLight ?? alias.light
    }

    var darkIncreased: DS.Theme.Inventory.ColorReference {
        alias.increasedDark ?? alias.dark
    }

    static func groups(of entries: [DS.Theme.Inventory.SemanticEntry]) -> [(name: String, tokens: [Self])] {
        var groups: [(name: String, tokens: [Self])] = []
        for entry in entries where entry.kind == .color {
            guard case .color(let path) = entry.path, case .color(let alias) = entry.value else { continue }
            let token = Self(name: "\(entry.group).\(entry.name)", path: path, alias: alias)
            if let index = groups.firstIndex(where: { $0.name == entry.group }) {
                groups[index].tokens.append(token)
            } else {
                groups.append((entry.group, [token]))
            }
        }
        return groups
    }

    private static func text(of reference: DS.Theme.Inventory.ColorReference) -> String {
        guard let opacity = reference.opacity else { return reference.color }
        return "\(reference.color) @ \(opacity)"
    }
}
