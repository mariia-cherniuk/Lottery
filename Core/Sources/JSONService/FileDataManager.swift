import Foundation

protocol FileDataManaging {
    func read(from url: URL) throws -> Data
}

struct FileDataManager: FileDataManaging {
    
    func read(from url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
}
