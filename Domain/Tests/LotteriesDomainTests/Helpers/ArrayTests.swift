import XCTest

@testable import LotteriesDomain

final class ArrayTests: XCTestCase {

    func testHaveCommonElements() {
        let array1 = ["1", "2", "Hello", "4"]
        let array2 = ["1", "2", "Hello", "44"]
        let array3 = ["11", "22", "Hi", "44"]
        
        var haveCommonElements = array1.haveCommonElements(numberOfCummonElements: 1, array: array2)
        XCTAssertTrue(haveCommonElements)
        
        haveCommonElements = array1.haveCommonElements(numberOfCummonElements: 3, array: array2)
        XCTAssertTrue(haveCommonElements)
        
        haveCommonElements = array1.haveCommonElements(numberOfCummonElements: 4, array: array2)
        XCTAssertFalse(haveCommonElements)
        
        haveCommonElements = array1.haveCommonElements(numberOfCummonElements: 1, array: array3)
        XCTAssertFalse(haveCommonElements)
    }
}
