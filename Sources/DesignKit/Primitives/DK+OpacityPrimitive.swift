extension DK {
    package struct OpacityPrimitive: Primitive {
        package static let scale = "opacity"

        package let name: String
        package let percent: Int

        package static let opacity15 = OpacityPrimitive(name: "opacity15", percent: 15)
        package static let opacity20 = OpacityPrimitive(name: "opacity20", percent: 20)
        package static let opacity30 = OpacityPrimitive(name: "opacity30", percent: 30)

        package static let all: [OpacityPrimitive] = [
            .opacity15,
            .opacity20,
            .opacity30,
        ]

        package var fraction: Double {
            Double(percent) / 100
        }
    }
}
