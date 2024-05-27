import XCTest
@testable import Formatters

final class DateFormatterTests: XCTestCase {
    
    func testMonthDateFormatter() {
        let result = DateFormatter.monthDateFormatter.string(from: .fixture())
        
        XCTAssertEqual(result, "15 May 2023")
    }
    
    func testDrawDateFormatter() {
        let result = DateFormatter.drawDateFormatter.string(from: .fixture())
        
        XCTAssertEqual(result, "2023-05-15")
    }
}

fileprivate extension Date {
    
    static func fixture(day: Int = 15, month: Int = 5, year: Int = 2023) -> Self {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        // Use the current calendar to create the date
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)!
    }
}
