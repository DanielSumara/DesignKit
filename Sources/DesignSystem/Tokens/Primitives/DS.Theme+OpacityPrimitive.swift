extension DS.Theme {
    struct OpacityPrimitive: Primitive {
        static let scale = "opacity"

        let name: String
        let percent: Int

        static let opacity15 = OpacityPrimitive(name: "opacity15", percent: 15)
        static let opacity20 = OpacityPrimitive(name: "opacity20", percent: 20)
        static let opacity30 = OpacityPrimitive(name: "opacity30", percent: 30)

        static let all: [OpacityPrimitive] = [
            .opacity15,
            .opacity20,
            .opacity30,
        ]

        var fraction: Double {
            Double(percent) / 100
        }
    }
}
