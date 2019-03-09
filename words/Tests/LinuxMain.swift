import XCTest

import wordsTests

var tests = [XCTestCaseEntry]()
tests += wordsTests.allTests()
XCTMain(tests)