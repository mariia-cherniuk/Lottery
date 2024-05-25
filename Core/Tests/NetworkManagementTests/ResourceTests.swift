import XCTest
@testable import NetworkManagement

final class ResourceTests: XCTestCase {

    func testRequest() {
        let method = HTTPMethod.GET
        let resource = Resource(path: "/path", method: method)
        let environment = Environment(schema: "https", host: "example.com")
       
        let request = resource.request(relativeTo: environment)
        
        XCTAssertEqual(request.url?.scheme, "https")
        XCTAssertEqual(request.url?.host, "example.com")
        XCTAssertEqual(request.url?.pathComponents.first, "/")
        XCTAssertEqual(request.url?.pathComponents.last, "path")
        XCTAssertEqual(request.url?.absoluteString, "https://example.com/path")
        XCTAssertNil(request.url?.query)
        XCTAssertEqual(request.httpMethod, method.rawValue)
    }
}
