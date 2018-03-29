import XCTest
@testable import SwiftyAlgebra

class SwiftyAlgebraTests: XCTestCase {
    func testExample() {
        let a = 𝐐(4, 5)  // 4/5
        let b = 𝐐(3, 2)  // 3/2
        
        let sum      = a + b  // 23/10
        let product  = a * b  // 6/5
        let quotient = b / a  // 15/8
        
        XCTAssertEqual(sum,      𝐐(23, 10))
        XCTAssertEqual(product,  𝐐(6, 5))
        XCTAssertEqual(quotient, 𝐐(15, 8))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
