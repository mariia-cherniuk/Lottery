import Foundation

public protocol JSONServiceProtocol {
    func fetch<T: Decodable>(from url: URL) throws -> T
}

public enum JSONError: Error {
    case unableToReadFromURL, unableToDecode
}

public struct JSONService: JSONServiceProtocol {
    
    private let fileManager: FileDataManaging
    
    public init(fileManager: FileDataManaging) {
        self.fileManager = fileManager
    }
    
    public func fetch<T: Decodable>(from url: URL) throws -> T {
        guard let data = try? fileManager.read(from: url) else {
            print("Unable to read content of: \(url)") //TODO: Implement logger
            throw JSONError.unableToReadFromURL
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data) //TODO: Inject decoder
            return decoded
        } catch {
            print("Unable to decode content of: \(error.localizedDescription)") //TODO: Implement logger
            throw JSONError.unableToDecode
        }
    }
}
