import Foundation
import JSONService

final class MockFileDataManager: FileDataManaging {
    
    func read(from url: URL) throws -> Data {
        Data()
    }
}
