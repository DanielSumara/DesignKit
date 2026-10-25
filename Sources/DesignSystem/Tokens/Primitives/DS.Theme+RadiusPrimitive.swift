extension DS.Theme {
    struct RadiusPrimitive: Primitive {
        static let scale = "radius"

        let name: String
        let points: Double

        static let radius4 = RadiusPrimitive(name: "radius4", points: 4)
        static let radius8 = RadiusPrimitive(name: "radius8", points: 8)
        static let radius12 = RadiusPrimitive(name: "radius12", points: 12)
        static let radius20 = RadiusPrimitive(name: "radius20", points: 20)

        static let all: [RadiusPrimitive] = [
            .radius4,
            .radius8,
            .radius12,
            .radius20,
        ]
    }
}
