#if !canImport(ObjectiveC)
import XCTest

extension OrderedSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__OrderedSetTests = [
        ("testDecode", testDecode),
        ("testEncode", testEncode),
        ("testEqual", testEqual),
        ("testFilter", testFilter),
        ("testFormSymmetricDifference", testFormSymmetricDifference),
        ("testFormUnion", testFormUnion),
        ("testGet", testGet),
        ("testHashable", testHashable),
        ("testInsert1", testInsert1),
        ("testInsert2", testInsert2),
        ("testIntersection1", testIntersection1),
        ("testIntersection2", testIntersection2),
        ("testNotEqual", testNotEqual),
        ("testRemove1", testRemove1),
        ("testRemove2", testRemove2),
        ("testSetExisting", testSetExisting),
        ("testSetNew", testSetNew),
        ("testSubtract", testSubtract),
        ("testSubtracting", testSubtracting),
        ("testSymmetricDifference", testSymmetricDifference),
        ("testUnion", testUnion),
        ("testUpdate", testUpdate),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(OrderedSetTests.__allTests__OrderedSetTests),
    ]
}
#endif
