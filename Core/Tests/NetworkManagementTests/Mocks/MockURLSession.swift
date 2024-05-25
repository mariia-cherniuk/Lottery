import Foundation
import XCTest
@testable import NetworkManagement

final class MockURLSession: URLSessionProtocol {
    
    var stubResponses: (() throws -> (Data, URLResponse))?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let stubResponses else {
            throw NSError(domain: "MockURLSession", code: 0, userInfo: [NSLocalizedDescriptionKey: "No stub response was set"])
        }
        return try stubResponses()
    }
}
