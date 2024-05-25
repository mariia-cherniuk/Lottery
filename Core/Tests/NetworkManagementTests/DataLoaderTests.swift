import XCTest
@testable import NetworkManagement

final class DataLoaderTests: XCTestCase {
   
    private let resource = Resource(path: "/test", method: .GET)
    private let fakeEnvironment = Environment(schema: "https", host: "example.com")
    
    private var dataLoader: DataLoader!
    private var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        dataLoader = DataLoader(session: mockURLSession, environment: fakeEnvironment)
    }
    
    override func tearDown() {
        mockURLSession = nil
        dataLoader = nil
        super.tearDown()
    }
    
    // MARK: - Test Success
    func testGivenResponsSuccessWithData_WhenFetchIsCalled_ThenResponseIsSuccessWithCorrectValue() async {
        let dataToReturn = Data("3".utf8)
        mockURLSession.stubResponses = {
            return (dataToReturn, HTTPURLResponse.success)
        }
        
        do {
            let data = try await dataLoader.fetch(resource: resource)
            XCTAssertEqual(data, dataToReturn)
        } catch {
            return XCTFail("Result should be success")
        }
    }
    
    // MARK: - Test Failure
    func testGivenInvalidResponse_WhenFetchIsCalled_ThenResponseIsFailureWithInvalidResponseError() async {
        mockURLSession.stubResponses = {
            return (Data(), HTTPURLResponse.invalidResponse)
        }
        
        do {
            let _ = try await dataLoader.fetch(resource: resource)
            return XCTFail("Fetch should fail")
        } catch {
            guard let networkError = error as? NetworkError,
                  case .invalidResponse = networkError else {
                return XCTFail("Error should be invalidResponse")
            }
        }
    }
    
    func testGivenError_WhenFetchIsCalled_ThenResponseIsFailureWithNetworkError() async {
        mockURLSession.stubResponses = {
            throw MockError()
        }
        
        do {
            let _ = try await dataLoader.fetch(resource: resource)
            return XCTFail("Fetch should fail")
        } catch {
            guard let error = error as? NetworkError,
                  case .networkError(let mockError) = error else {
                return XCTFail("Error should be networkError")
            }
            
            XCTAssertTrue(mockError is MockError)
        }
    }
    
    func testGivenNotConnectedToInternetError_WhenFetchIsCalled_ThenResponseIsFailureWithNetworkError() async {
        mockURLSession.stubResponses = {
            throw URLError(.notConnectedToInternet)
        }
        
        do {
            let _ = try await dataLoader.fetch(resource: resource)
            return XCTFail("Fetch should fail")
        } catch {
            guard let error = error as? NetworkError, case .notConnectedToInternet = error else {
                return XCTFail("Error should be notConnectedToInternet")
            }
        }
    }
    
    func testGivenNoResponseSet_WhenFetchIsCalled_ThenResponseIsFailureWithNSError() async {
        ///Just to test a mock object, not a necessary test
        mockURLSession.stubResponses = nil
        
        do {
            let _ = try await dataLoader.fetch(resource: resource)
            return XCTFail("Fetch should fail")
        } catch {
            guard let error = error as? NetworkError, case .networkError(let sessionError) = error else {
                return XCTFail("Error should be networkError")
            }
            
            XCTAssertEqual(sessionError.localizedDescription, "No stub response was set")
        }
    }
}
