import Foundation
import JSONService

struct MockError: Error {}

final class MockJSONService: JSONServiceProtocol {
    
    var capturedURL: URL?
    var stubResult: (() throws -> Any)?
    
    func fetch<T: Decodable>(from url: URL) throws -> T {
        capturedURL = url
        
        guard let result = try stubResult?() else {
            throw MockError()
        }
        
        guard let typedResult = result as? T else {
            throw MockError()
        }
        
        return typedResult
    }
}
