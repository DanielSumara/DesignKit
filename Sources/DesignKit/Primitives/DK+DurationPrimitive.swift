extension DK {
    package struct DurationPrimitive: Primitive {
        package static let scale = "duration"

        package let name: String
        package let milliseconds: Int

        package static let duration150 = DurationPrimitive(name: "duration150", milliseconds: 150)
        package static let duration250 = DurationPrimitive(name: "duration250", milliseconds: 250)
        package static let duration400 = DurationPrimitive(name: "duration400", milliseconds: 400)

        package static let all: [DurationPrimitive] = [
            .duration150,
            .duration250,
            .duration400,
        ]

        package var seconds: Double {
            Double(milliseconds) / 1000
        }
    }
}
