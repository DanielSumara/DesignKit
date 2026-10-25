extension DS.Theme {
    struct StrokePrimitive: Primitive {
        static let scale = "stroke"

        let name: String
        let points: Double

        static let stroke1 = StrokePrimitive(name: "stroke1", points: 1)
        static let stroke2 = StrokePrimitive(name: "stroke2", points: 2)
        static let stroke3 = StrokePrimitive(name: "stroke3", points: 3)

        static let all: [StrokePrimitive] = [
            .stroke1,
            .stroke2,
            .stroke3,
        ]
    }
}
