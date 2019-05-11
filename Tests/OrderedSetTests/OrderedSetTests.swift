import XCTest
@testable import OrderedSet

final class OrderedSetTests: XCTestCase {

    func testInsert1() {
        var a: OrderedSet = [3, 2, 1, 4]
        a.insert(5)
        XCTAssertEqual(a, [3, 2, 1, 4, 5])
    }

    func testInsert2() {
        var a: OrderedSet = [3, 2, 1, 4]
        a.insert(2)
        XCTAssertEqual(a, [3, 2, 1, 4])
    }

    func testRemove1() {
        var a: OrderedSet = [3, 2, 1, 4]
        a.remove(2)
        XCTAssertEqual(a, [3, 1, 4])
    }

    func testRemove2() {
        var a: OrderedSet = [3, 2, 1, 4]
        a.remove(5)
        XCTAssertEqual(a, [3, 2, 1, 4])
    }

    func testFilter() {
        let a: OrderedSet = [3, 2, 1, 4]
        XCTAssertEqual(a.filter { $0 > 2 }, [3, 4])
    }

    func testIntersection1() {
        let a: OrderedSet = [5, 3, 1, 2, 4]
        let b: OrderedSet = [2, 3, 1]
        XCTAssertEqual(a.intersection(b), [3, 1, 2])
    }

    func testIntersection2() {
        let a: OrderedSet = [1, 3, 5]
        let b: OrderedSet = [1, 2, 5]
        XCTAssertEqual(a.intersection(b), [1, 5])
    }

    func testSubtract() {
        var a: OrderedSet = [1, 2, 3, 4]
        let b: OrderedSet = [2, 4, 5]
        a.subtract(b)
        XCTAssertEqual(a, [1, 3])
    }

    func testSubtracting() {
        var a: OrderedSet = [6, 4, 2, 3, 1]
        let b: OrderedSet = [2, 4, 5]
        a.subtract(b)
        XCTAssertEqual(a, [6, 3, 1])
    }

    func testUnion() {
        let a: OrderedSet = [3, 2, 5, 1]
        let b: OrderedSet = [2, 4]
        XCTAssertEqual(a.union(b), [3, 2, 5, 1, 4])
    }

    func testFormUnion() {
        var a: OrderedSet = [3, 2, 5, 1]
        let b: OrderedSet = [2, 4]
        a.formUnion(b)
        XCTAssertEqual(a, [3, 2, 5, 1, 4])
    }

    func testUpdate() {
        var a: OrderedSet = [3, 2, 5]
        XCTAssertEqual(a.update(with: 1), nil)
        XCTAssertEqual(a, [3, 2, 5, 1])
        XCTAssertEqual(a.update(with: 2), 2)
        XCTAssertEqual(a, [3, 2, 5, 1])
    }

    func testSymmetricDifference() {
        let a: OrderedSet = [3, 2, 1, 4]
        let b: OrderedSet = [5, 2, 4]
        XCTAssertEqual(a.symmetricDifference(b), [3, 1, 5])
    }

    func testFormSymmetricDifference() {
        var a: OrderedSet = [3, 2, 1, 4]
        let b: OrderedSet = [5, 2, 4]
        a.formSymmetricDifference(b)
        XCTAssertEqual(a, [3, 1, 5])
    }

    func testNotEqual() {
        let a: OrderedSet = [3, 2, 5]
        let b: OrderedSet = [2, 3, 5]
        XCTAssertNotEqual(a, b)
    }

    func testEqual() {
        let a: OrderedSet = [3, 2, 5]
        let b: OrderedSet = [3, 2, 5]
        XCTAssertEqual(a, b)
    }

    func testGet() {
        let a: OrderedSet = [3, 6, 4, 2, 3, 1, 6]
        XCTAssertEqual(a[0], 3)
        XCTAssertEqual(a[1], 6)
        XCTAssertEqual(a[2], 4)
        XCTAssertEqual(a[3], 2)
        XCTAssertEqual(a[4], 1)
        XCTAssertEqual(a.count, 5)
    }

    func testSetExisting() {
        var a: OrderedSet = [3, 6, 4, 2, 3, 1, 6]
        XCTAssertEqual(a, [3, 6, 4, 2, 1])
        a[1] = 3
        XCTAssertEqual(a[0], 3)
        XCTAssertEqual(a[1], 4)
        XCTAssertEqual(a[2], 2)
        XCTAssertEqual(a[3], 1)
        XCTAssertEqual(a.count, 4)
        XCTAssertFalse(a.contains(6))
        XCTAssertTrue(a.contains(3))
    }

    func testSetNew() {
        var a: OrderedSet = [3, 6, 4, 2, 3, 1, 6]
        XCTAssertEqual(a, [3, 6, 4, 2, 1])
        a[1] = 7
        XCTAssertEqual(a[0], 3)
        XCTAssertEqual(a[1], 7)
        XCTAssertEqual(a[2], 4)
        XCTAssertEqual(a[3], 2)
        XCTAssertEqual(a[4], 1)
        XCTAssertEqual(a.count, 5)
        XCTAssertFalse(a.contains(6))
        XCTAssertTrue(a.contains(7))
    }

    func testEncode() {
        let a: OrderedSet = [3, 6, 4, 2, 3, 1, 6]
        XCTAssertEqual(
            String(data: try JSONEncoder().encode(a), encoding: .utf8),
            "[3,6,4,2,1]"
        )
    }

    func testDecode() {
        XCTAssertEqual(
            try JSONDecoder().decode(
                OrderedSet<Int>.self,
                from: "[3, 6, 4, 2, 3, 1, 6]".data(using: .utf8)!
            ),
            OrderedSet([3, 6, 4, 2, 1])
        )
    }

    func testHashable() {
        _ = Set([OrderedSet([1])])
    }
}
