import XCTest
@testable import LotteriesFeature

final class CurrencyFormatterTests: XCTestCase {
    
    private var formatter: NumberFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = NumberFormatter.currency
    }
    
    override func tearDown() {
        formatter = nil
        super.tearDown()
    }
    
    func testGBPString() {
        let currencyFormatter = CurrencyFormatter(formatter: formatter)
        let result = currencyFormatter.string(from: 1050, currencyCode: "GBP")
        
        XCTAssertEqual(result, "£10.50")
    }
    
    func testUSDString() {
        let currencyFormatter = CurrencyFormatter(formatter: formatter)
        formatter.locale = Locale(identifier: "en_US")
        let result = currencyFormatter.string(from: 4000000000, currencyCode: "USD")
        
        XCTAssertEqual(result, "$40,000,000.00")
    }
}
