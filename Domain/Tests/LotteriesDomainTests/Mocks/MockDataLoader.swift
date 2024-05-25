import NetworkManagement
import Foundation

struct MockError: Error {}

final class MockDataLoader: DataLoading {
    
    var capturedResource: Resource?
    var stubResponse: (() throws -> Data)?
    
    func fetch(resource: Resource) async throws -> Data {
        capturedResource = resource
        
        guard let stubResponse else {
            throw MockError()
        }
        return try stubResponse()
    }
}
