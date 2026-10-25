extension DK {
    package struct RadiusPrimitive: Primitive {
        package static let scale = "radius"

        package let name: String
        package let points: Double

        package static let radius4 = RadiusPrimitive(name: "radius4", points: 4)
        package static let radius8 = RadiusPrimitive(name: "radius8", points: 8)
        package static let radius12 = RadiusPrimitive(name: "radius12", points: 12)
        package static let radius20 = RadiusPrimitive(name: "radius20", points: 20)

        package static let all: [RadiusPrimitive] = [
            .radius4,
            .radius8,
            .radius12,
            .radius20,
        ]
    }
}
