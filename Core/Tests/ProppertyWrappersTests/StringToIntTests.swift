import XCTest
@testable import ProppertyWrappers

final class StringToIntTests: XCTestCase {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private struct TestStruct: Codable, Equatable {
        @StringToInt var value: Int
    }
    
    func testEncodingValidInteger() throws {
        let testStruct = TestStruct(value: 123)
        let encodedData = try encoder.encode(testStruct)
        let jsonString = String(data: encodedData, encoding: .utf8)
        
        XCTAssertEqual(jsonString, "{\"value\":\"123\"}")
    }
    
    func testDecodingValidIntegerString() throws {
        let jsonData = "{\"value\":\"123\"}".data(using: .utf8)!
        let decodedStruct = try decoder.decode(TestStruct.self, from: jsonData)
        
        XCTAssertEqual(decodedStruct.value, 123)
    }
    
    func testDecodingInvalidIntegerString() {
        let jsonData = "{\"value\":\"abc\"}".data(using: .utf8)!
        
        XCTAssertThrowsError(try decoder.decode(TestStruct.self, from: jsonData)) { error in
            guard case DecodingError.dataCorrupted(let context) = error else {
                return XCTFail("Expected dataCorrupted error")
            }
            XCTAssertEqual(context.debugDescription, "Expected an integer value but got a string: abc")
        }
    }
    
    func testDecodingValidInteger() throws {
        let jsonData = "{\"value\":\"456\"}".data(using: .utf8)!
        let decodedStruct = try decoder.decode(TestStruct.self, from: jsonData)
        
        XCTAssertEqual(decodedStruct.value, 456)
    }
    
    func testEncodingAndDecodingValidInteger() throws {
        let testStruct = TestStruct(value: 789)
        let encodedData = try encoder.encode(testStruct)
        let decodedStruct = try decoder.decode(TestStruct.self, from: encodedData)
        
        XCTAssertEqual(decodedStruct.value, 789)
    }
    
    func testEncodingAndDecodingNegativeInteger() throws {
        let testStruct = TestStruct(value: -123)
        let encodedData = try encoder.encode(testStruct)
        let decodedStruct = try decoder.decode(TestStruct.self, from: encodedData)
        
        XCTAssertEqual(decodedStruct.value, -123)
    }
    
    func testEncodingAndDecodingZero() throws {
        let testStruct = TestStruct(value: 0)
        let encodedData = try encoder.encode(testStruct)
        let decodedStruct = try decoder.decode(TestStruct.self, from: encodedData)
        
        XCTAssertEqual(decodedStruct.value, 0)
    }
}
