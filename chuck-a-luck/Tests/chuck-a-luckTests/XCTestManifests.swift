import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(chuck_a_luckTests.allTests),
    ]
}
#endif