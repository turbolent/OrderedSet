
/// An ordered set is a mutable random access collection of unique instances of `Element`,
/// which behaves like a set, but guarantees insertion order.
///
public struct OrderedSet<Element>: RandomAccessCollection, MutableCollection
    where Element: Hashable
{
    public typealias Index = Int
    public typealias Indices = Range<Int>

    fileprivate var array: [Element]
    fileprivate var set: Set<Element>

    public init() {
        self.array = []
        self.set = []
    }

    public init(_ array: [Element]) {
        self.init()
        array.forEach {
            insert($0)
        }
    }

    public subscript(position: Int) -> Element {
        get {
            return array[position]
        }
        set {
            let oldValue = array[position]
            set.remove(oldValue)
            array[position] = newValue
            set.insert(newValue)
            array = array.removingDuplicates()
        }
    }

    public var startIndex: Int {
        return array.startIndex
    }

    public var endIndex: Int {
        return array.endIndex
    }

    public var count: Int {
        return array.count
    }

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public func contains(_ element: Element) -> Bool {
        return set.contains(element)
    }
}


extension OrderedSet: SetAlgebra {

    @discardableResult
    public mutating func insert(_ newMember: Element)
        -> (inserted: Bool, memberAfterInsert: Element)
    {
        let (inserted, memberAfterInsert) = set.insert(newMember)
        if inserted {
            array.append(newMember)
        }
        return (inserted, memberAfterInsert)
    }

    public mutating func update(with newMember: Element) -> Element? {
        let index = array.firstIndex(of: newMember)
        let existingMember = set.update(with: newMember)
        if let index = index {
            array[index] = newMember
        } else {
            array.append(newMember)
        }
        return existingMember
    }

    @discardableResult
    public mutating func remove(_ member: Element) -> Element? {
        guard let index = array.firstIndex(of: member) else {
            return nil
        }
        set.remove(member)
        return array.remove(at: index)
    }

    public func isSubset(of other: OrderedSet<Element>) -> Bool {
        return set.isSubset(of: other.set)
    }

    public func isStrictSubset(of other: OrderedSet<Element>) -> Bool {
        return set.isStrictSubset(of: other.set)
    }

    public func isSuperset(of other: OrderedSet<Element>) -> Bool {
        return set.isSuperset(of: other.set)
    }

    public func isStrictSuperset(of other: OrderedSet<Element>) -> Bool {
        return set.isStrictSuperset(of: other.set)
    }

    public func isDisjoint(with other: OrderedSet<Element>) -> Bool {
        return set.isDisjoint(with: other.set)
    }

    public func intersection(_ other: OrderedSet<Element>) -> OrderedSet<Element> {
        var newSet = self
        newSet.formIntersection(other)
        return newSet
    }

    public mutating func formIntersection(_ other: OrderedSet<Element>) {
        set.formIntersection(other.set)
        array = array.filter(set.contains)
    }

    public func subtracting(_ other: OrderedSet<Element>) -> OrderedSet<Element> {
        var newSet = self
        newSet.subtract(other)
        return newSet
    }

    public mutating func subtract(_ other: OrderedSet<Element>) {
        set.subtract(other.set)
        array = array.filter(set.contains)
    }

    public func union(_ other: OrderedSet<Element>) -> OrderedSet<Element> {
        var newSet = self
        newSet.formUnion(other)
        return newSet
    }

    public mutating func formUnion(_ other: OrderedSet<Element>) {
        other.forEach { insert($0) }
    }

    public func symmetricDifference(_ other: OrderedSet<Element>) -> OrderedSet<Element> {
        var newSet = self
        newSet.formSymmetricDifference(other)
        return newSet
    }

    public mutating func formSymmetricDifference(_ other: OrderedSet<Element>) {
        set.formSymmetricDifference(other.set)
        array = (array + other.array)
            .removingDuplicates()
            .filter { set.contains($0) }
    }
}


extension OrderedSet: CustomStringConvertible {

    public var description: String {
        return array.description
    }
}


extension OrderedSet: CustomDebugStringConvertible {

    public var debugDescription: String {
        return array.debugDescription
    }
}


extension OrderedSet: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}


extension OrderedSet: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(array)
    }
}


extension OrderedSet: Equatable {

    public static func == <Element>(
        lhs: OrderedSet<Element>,
        rhs: OrderedSet<Element>
    )
        -> Bool
    {
        return lhs.array == rhs.array
    }
}


extension OrderedSet: Decodable where Element: Decodable {

    public init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            insert(try container.decode(Element.self))
        }
    }
}


extension OrderedSet: Encodable where Element: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try forEach {
            try container.encode($0)
        }
    }
}
