import XCTest
@testable import Storage

final class KeyValueStorageTests: XCTestCase {
    
    private let testValue = "FakeValue"
    private let testKey = "FakeKey"
    
    private var keyValueStorage: KeyValueStorage!
    private var mockDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        mockDefaults = MockUserDefaults()
        keyValueStorage = KeyValueStorage(defaults: mockDefaults)
    }
    
    override func tearDown() {
        mockDefaults = nil
        keyValueStorage = nil
        super.tearDown()
    }
    
    func testStore() {
        do {
            try keyValueStorage.store(value: testValue, for: testKey)
            
            let storedData = mockDefaults.data(forKey: testKey)
            XCTAssertNotNil(storedData)
            
            let decodedString = try JSONDecoder().decode(String.self, from: storedData!)
            XCTAssertEqual(decodedString, testValue)
        } catch {
            return XCTFail("Should store with success")
        }
    }
    
    func testGetValue() {
        do {
            let data = try JSONEncoder().encode(testValue)
            mockDefaults.set(data, forKey: testKey)
            
            let fetchedValue: String? = try keyValueStorage.getValue(for: testKey)
            XCTAssertNotNil(fetchedValue)
            XCTAssertEqual(fetchedValue, testValue)
        } catch {
            return XCTFail("Should get value with success")
        }
    }
    
    func testGetValueNoData() {
        let testKey = "nonexistentKey"
        
        do {
            let fetchedValue: String? = try keyValueStorage.getValue(for: testKey)
            XCTAssertNil(fetchedValue, "Should return nil for nonexistent keys")
        } catch {
            return XCTFail("Should get value with success")
        }
    }
}
