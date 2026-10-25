import DesignKit
import SwiftUI

extension DS.Theme {
    public struct AdaptiveColor: Hashable, Sendable, ShapeStyle {
        struct Alias: Hashable, Sendable {
            let color: DK.ColorPrimitive
            let opacity: DK.OpacityPrimitive?

            init(_ color: DK.ColorPrimitive, opacity: DK.OpacityPrimitive? = nil) {
                self.color = color
                self.opacity = opacity
            }

            var value: Color {
                let base = Color(color)
                guard let opacity else { return base }
                return base.opacity(opacity.fraction)
            }
        }

        private let light: Alias
        private let dark: Alias
        private let increasedLight: Alias?
        private let increasedDark: Alias?

        init(light: Alias, dark: Alias, increasedLight: Alias? = nil, increasedDark: Alias? = nil) {
            self.light = light
            self.dark = dark
            self.increasedLight = increasedLight
            self.increasedDark = increasedDark
        }

        init(_ both: Alias, increased: Alias? = nil) {
            self.init(light: both, dark: both, increasedLight: increased, increasedDark: increased)
        }

        init(
            light: DK.ColorPrimitive,
            dark: DK.ColorPrimitive,
            increasedLight: DK.ColorPrimitive? = nil,
            increasedDark: DK.ColorPrimitive? = nil
        ) {
            self.init(
                light: Alias(light),
                dark: Alias(dark),
                increasedLight: increasedLight.map { Alias($0) },
                increasedDark: increasedDark.map { Alias($0) }
            )
        }

        init(_ both: DK.ColorPrimitive, increased: DK.ColorPrimitive? = nil) {
            self.init(Alias(both), increased: increased.map { Alias($0) })
        }

        public func resolve(in environment: EnvironmentValues) -> Color.Resolved {
            let isDark = environment.colorScheme == .dark
            let isIncreased = environment.colorSchemeContrast == .increased
            let normal = isDark ? dark : light
            let increased = isDark ? increasedDark : increasedLight
            return (isIncreased ? increased ?? normal : normal).value.resolve(in: environment)
        }
    }
}

extension DS.Theme.AdaptiveColor {
    var inventoryAlias: DS.Theme.Inventory.ColorAlias {
        DS.Theme.Inventory.ColorAlias(
            light: DS.Theme.Inventory.ColorReference(light),
            dark: DS.Theme.Inventory.ColorReference(dark),
            increasedLight: increasedLight.map { DS.Theme.Inventory.ColorReference($0) },
            increasedDark: increasedDark.map { DS.Theme.Inventory.ColorReference($0) }
        )
    }
}

private extension Color {
    init(_ primitive: DK.ColorPrimitive) {
        switch primitive.value {
        case .srgb(let hex):
            self.init(
                .sRGB,
                red: Double(hex >> 16 & 0xFF) / 255,
                green: Double(hex >> 8 & 0xFF) / 255,
                blue: Double(hex & 0xFF) / 255
            )
        case .system:
            self = .accentColor
        }
    }
}
