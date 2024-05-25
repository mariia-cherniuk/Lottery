import Foundation

struct MockError: Error {}

extension HTTPURLResponse {
    
    static var success: HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://example.com")!,
                        statusCode: 200,
                        httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    static var invalidResponse: HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://example.com")!,
                        statusCode: 404,
                        httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}

