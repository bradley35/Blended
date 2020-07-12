import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TrackingToBlenderTests.allTests),
    ]
}
#endif
