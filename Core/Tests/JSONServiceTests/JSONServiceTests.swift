import XCTest
@testable import JSONService

final class JSONServiceTests: XCTestCase {
    
    //TODO: Test objects or fixtures should be isolated within the Fixtures directory. However, currently, this object is being used only within this file, which is why I declared it here
    private struct MockData: Decodable {
        let id: Int
        let name: String
    }
    
    private let fakeURL = URL(string: "fake.url")!
    
    private var mockFileDataManager: MockFileDataManager!
    private var service: JSONService!
    
    override func setUp() {
        super.setUp()
        mockFileDataManager = MockFileDataManager()
        service = JSONService(fileManager: mockFileDataManager)
    }
    
    override func tearDown() {
        mockFileDataManager = nil
        service = nil
        super.tearDown()
    }
    
    // MARK: - Test success
    func testGivenValidDataExists_WhenCallFetch_ThenResultIsSuccessWithMockData() {
        let testJSON = "{\"id\": 1, \"name\": \"Test\"}"
        mockFileDataManager.stubData = Data(testJSON.utf8)
        
        do {
            let result: MockData = try service.fetch(from: fakeURL)
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.name, "Test")
        } catch {
            return XCTFail("Result should be success")
        }
        
        XCTAssertEqual(mockFileDataManager.capturedURL?.absoluteString, "fake.url")
    }
    
    // MARK: - Test failure
    func testGivenInvalidData_WhenCallFetch_ThenResultIsFailureWithUnableToDecodeError() {
        mockFileDataManager.stubData = Data("Invalid JSON Data".utf8)
        
        do {
            let _: MockData = try service.fetch(from: fakeURL)
            return XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? JSONError else {
                return XCTFail("Error should be JSONError")
            }
            
            guard case .unableToDecode = capturedError else {
                return XCTFail("Error should be unableToDecode")
            }
        }
        
        XCTAssertEqual(mockFileDataManager.capturedURL?.absoluteString, "fake.url")
    }
    
    func testGivenDataDoesNotExist_WhenCallFetch_ThenResultIsFailureWithUnableToReadFromURLError() {
        mockFileDataManager.stubData = nil
        
        do {
            let _: MockData = try service.fetch(from: fakeURL)
            return XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? JSONError else {
                return XCTFail("Error should be JSONError")
            }
            
            guard case .unableToReadFromURL = capturedError else {
                return XCTFail("Error should be unableToReadFromURL")
            }
        }
        
        XCTAssertEqual(mockFileDataManager.capturedURL?.absoluteString, "fake.url")
    }
}
