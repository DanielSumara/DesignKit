internal struct ComponentProperty: Identifiable {
    let name: String
    let type: String
    let defaultValue: String

    var id: String { name }
}
