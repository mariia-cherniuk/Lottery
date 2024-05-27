import XCTest
@testable import Formatters

final class NSDecimalNumberTests: XCTestCase {
    
    func testDecimalFrom() {
        var result = NSDecimalNumber.decimal(from: 1000)
        XCTAssertEqual(result, 10)
        
        result = NSDecimalNumber.decimal(from: 10000)
        XCTAssertEqual(result, 100)
    }
}
