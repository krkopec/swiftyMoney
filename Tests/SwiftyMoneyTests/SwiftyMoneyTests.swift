import XCTest
@testable import SwiftyMoney

final class SwiftyMoneyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyMoney().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
