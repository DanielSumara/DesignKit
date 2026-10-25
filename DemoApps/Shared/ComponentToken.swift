internal struct ComponentToken: Identifiable {
    let token: String
    let aliasChain: [String]

    var id: String { token }
}
