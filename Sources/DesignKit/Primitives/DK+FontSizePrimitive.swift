extension DK {
    package struct FontSizePrimitive: Primitive {
        package static let scale = "fontSize"

        package let name: String
        package let points: Double

        package static let fontSize10 = FontSizePrimitive(name: "fontSize10", points: 10)
        package static let fontSize11 = FontSizePrimitive(name: "fontSize11", points: 11)
        package static let fontSize12 = FontSizePrimitive(name: "fontSize12", points: 12)
        package static let fontSize13 = FontSizePrimitive(name: "fontSize13", points: 13)
        package static let fontSize15 = FontSizePrimitive(name: "fontSize15", points: 15)
        package static let fontSize17 = FontSizePrimitive(name: "fontSize17", points: 17)
        package static let fontSize22 = FontSizePrimitive(name: "fontSize22", points: 22)
        package static let fontSize26 = FontSizePrimitive(name: "fontSize26", points: 26)

        package static let all: [FontSizePrimitive] = [
            .fontSize10,
            .fontSize11,
            .fontSize12,
            .fontSize13,
            .fontSize15,
            .fontSize17,
            .fontSize22,
            .fontSize26,
        ]
    }
}
