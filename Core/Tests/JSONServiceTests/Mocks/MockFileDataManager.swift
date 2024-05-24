import Foundation
@testable import JSONService

struct MockError: Error {}

final class MockFileDataManager: FileDataManaging {
 
    var stubData: Data?
    var capturedURL: URL?
    
    func read(from url: URL) throws -> Data {
        capturedURL = url
        
        guard let stubData else {
            throw MockError()
        }
        return stubData
    }
}
