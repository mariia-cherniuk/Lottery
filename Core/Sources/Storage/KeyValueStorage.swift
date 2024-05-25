import Foundation

public protocol KeyValueStorageProtocol {
    func store<T: Encodable>(value: T, for key: String) throws
    func getValue<T: Decodable>(for key: String) throws -> T?
}

public final class KeyValueStorage: KeyValueStorageProtocol {
    
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    public func store<T: Encodable>(value: T, for key: String) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
    }
    
    public func getValue<T: Decodable>(for key: String) throws -> T? {
        guard let data = defaults.data(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
