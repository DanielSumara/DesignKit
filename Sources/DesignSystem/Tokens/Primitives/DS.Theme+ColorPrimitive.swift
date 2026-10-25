extension DS.Theme {
    struct ColorPrimitive: Primitive {
        enum Value: Sendable, Hashable {
            case srgb(hex: UInt32)
            case system
        }

        static let scale = "color"

        let name: String
        let value: Value

        static let gray100 = ColorPrimitive(name: "gray100", value: .srgb(hex: 0xFFFFFF))
        static let gray11 = ColorPrimitive(name: "gray11", value: .srgb(hex: 0x1E1E1E))
        static let slate97 = ColorPrimitive(name: "slate97", value: .srgb(hex: 0xF5F5F7))
        static let slate94 = ColorPrimitive(name: "slate94", value: .srgb(hex: 0xEEEEF0))
        static let slate93 = ColorPrimitive(name: "slate93", value: .srgb(hex: 0xEBEBEE))
        static let slate84 = ColorPrimitive(name: "slate84", value: .srgb(hex: 0xD1D1D6))
        static let slate73 = ColorPrimitive(name: "slate73", value: .srgb(hex: 0xB4B4B9))
        static let slate66 = ColorPrimitive(name: "slate66", value: .srgb(hex: 0xA1A1A6))
        static let slate58 = ColorPrimitive(name: "slate58", value: .srgb(hex: 0x8B8B90))
        static let slate53 = ColorPrimitive(name: "slate53", value: .srgb(hex: 0x7E7E83))
        static let slate47 = ColorPrimitive(name: "slate47", value: .srgb(hex: 0x6E6E73))
        static let slate43 = ColorPrimitive(name: "slate43", value: .srgb(hex: 0x656569))
        static let slate42 = ColorPrimitive(name: "slate42", value: .srgb(hex: 0x636366))
        static let slate37 = ColorPrimitive(name: "slate37", value: .srgb(hex: 0x57575C))
        static let slate25 = ColorPrimitive(name: "slate25", value: .srgb(hex: 0x3C3C40))
        static let slate22 = ColorPrimitive(name: "slate22", value: .srgb(hex: 0x353538))
        static let slate19 = ColorPrimitive(name: "slate19", value: .srgb(hex: 0x2E2E31))
        static let slate17 = ColorPrimitive(name: "slate17", value: .srgb(hex: 0x29292B))
        static let slate11 = ColorPrimitive(name: "slate11", value: .srgb(hex: 0x1D1D1F))
        static let blue94 = ColorPrimitive(name: "blue94", value: .srgb(hex: 0xE7F0FD))
        static let blue76 = ColorPrimitive(name: "blue76", value: .srgb(hex: 0x8DBEFF))
        static let blue69 = ColorPrimitive(name: "blue69", value: .srgb(hex: 0x66AAFF))
        static let blue43 = ColorPrimitive(name: "blue43", value: .srgb(hex: 0x0A60D6))
        static let blue40 = ColorPrimitive(name: "blue40", value: .srgb(hex: 0x0058D0))
        static let blue35 = ColorPrimitive(name: "blue35", value: .srgb(hex: 0x0B4DB3))
        static let blue16 = ColorPrimitive(name: "blue16", value: .srgb(hex: 0x10284A))
        static let green95 = ColorPrimitive(name: "green95", value: .srgb(hex: 0xE5F4EA))
        static let green80 = ColorPrimitive(name: "green80", value: .srgb(hex: 0x7EDB98))
        static let green74 = ColorPrimitive(name: "green74", value: .srgb(hex: 0x3FCF6A))
        static let green45 = ColorPrimitive(name: "green45", value: .srgb(hex: 0x1E7B36))
        static let green43 = ColorPrimitive(name: "green43", value: .srgb(hex: 0x1A7431))
        static let green37 = ColorPrimitive(name: "green37", value: .srgb(hex: 0x17652C))
        static let green17 = ColorPrimitive(name: "green17", value: .srgb(hex: 0x0F2F1A))
        static let orange96 = ColorPrimitive(name: "orange96", value: .srgb(hex: 0xFFF1D9))
        static let orange83 = ColorPrimitive(name: "orange83", value: .srgb(hex: 0xFFC56B))
        static let orange78 = ColorPrimitive(name: "orange78", value: .srgb(hex: 0xFFB23E))
        static let orange74 = ColorPrimitive(name: "orange74", value: .srgb(hex: 0xF5A524))
        static let orange43 = ColorPrimitive(name: "orange43", value: .srgb(hex: 0xA64B00))
        static let orange36 = ColorPrimitive(name: "orange36", value: .srgb(hex: 0x874200))
        static let orange16 = ColorPrimitive(name: "orange16", value: .srgb(hex: 0x382505))
        static let red94 = ColorPrimitive(name: "red94", value: .srgb(hex: 0xFDE9E9))
        static let red75 = ColorPrimitive(name: "red75", value: .srgb(hex: 0xFF9D96))
        static let red68 = ColorPrimitive(name: "red68", value: .srgb(hex: 0xFF7F78))
        static let red44 = ColorPrimitive(name: "red44", value: .srgb(hex: 0xD0021B))
        static let red42 = ColorPrimitive(name: "red42", value: .srgb(hex: 0xC9001B))
        static let red35 = ColorPrimitive(name: "red35", value: .srgb(hex: 0xA8001A))
        static let red13 = ColorPrimitive(name: "red13", value: .srgb(hex: 0x3D1316))
        static let sand94 = ColorPrimitive(name: "sand94", value: .srgb(hex: 0xF6EEDC))
        static let sand15 = ColorPrimitive(name: "sand15", value: .srgb(hex: 0x2B2418))
        static let pink71 = ColorPrimitive(name: "pink71", value: .srgb(hex: 0xF48FB1))
        static let pink38 = ColorPrimitive(name: "pink38", value: .srgb(hex: 0xAD1457))
        static let accent = ColorPrimitive(name: "accent", value: .system)

        static let all: [ColorPrimitive] = [
            .gray100,
            .gray11,
            .slate97,
            .slate94,
            .slate93,
            .slate84,
            .slate73,
            .slate66,
            .slate58,
            .slate53,
            .slate47,
            .slate43,
            .slate42,
            .slate37,
            .slate25,
            .slate22,
            .slate19,
            .slate17,
            .slate11,
            .blue94,
            .blue76,
            .blue69,
            .blue43,
            .blue40,
            .blue35,
            .blue16,
            .green95,
            .green80,
            .green74,
            .green45,
            .green43,
            .green37,
            .green17,
            .orange96,
            .orange83,
            .orange78,
            .orange74,
            .orange43,
            .orange36,
            .orange16,
            .red94,
            .red75,
            .red68,
            .red44,
            .red42,
            .red35,
            .red13,
            .sand94,
            .sand15,
            .pink71,
            .pink38,
            .accent,
        ]
    }
}
