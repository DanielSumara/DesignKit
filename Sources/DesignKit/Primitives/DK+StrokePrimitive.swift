extension DK {
    package struct StrokePrimitive: Primitive {
        package static let scale = "stroke"

        package let name: String
        package let points: Double

        package static let stroke1 = StrokePrimitive(name: "stroke1", points: 1)
        package static let stroke2 = StrokePrimitive(name: "stroke2", points: 2)
        package static let stroke3 = StrokePrimitive(name: "stroke3", points: 3)

        package static let all: [StrokePrimitive] = [
            .stroke1,
            .stroke2,
            .stroke3,
        ]
    }
}
