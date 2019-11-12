import XCTest
@testable import Monolith

final class MonolithTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Monolith().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
