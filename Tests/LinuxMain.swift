import XCTest

import OrderedSetTests

var tests = [XCTestCaseEntry]()
tests += OrderedSetTests.__allTests()

XCTMain(tests)
