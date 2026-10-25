extension Array {
    func orderedGroups<Key: Hashable>(by key: (Element) -> Key) -> [(key: Key, elements: [Element])] {
        var groups: [(key: Key, elements: [Element])] = []
        var indices: [Key: Int] = [:]
        for element in self {
            let elementKey = key(element)
            if let index = indices[elementKey] {
                groups[index].elements.append(element)
            } else {
                indices[elementKey] = groups.count
                groups.append((elementKey, [element]))
            }
        }
        return groups
    }
}
