extension Sequence where Element: Hashable {

    public func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { element in
            seen.insert(element).inserted
        }
    }
}
