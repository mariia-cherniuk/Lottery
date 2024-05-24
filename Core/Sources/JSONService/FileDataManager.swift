import Foundation

public protocol FileDataManaging {
    func read(from url: URL) throws -> Data
}

public struct FileDataManager: FileDataManaging {
    
    public init() {}
    
    public func read(from url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
}
