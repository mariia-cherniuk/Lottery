import Storage
import XCTest

final class MockKeyValueStorage: KeyValueStorageProtocol {
  
    var stubStore: ((Any, String) -> Void)?
    
    func store<T: Encodable>(value: T, for key: String) throws {
        if let store = stubStore {
            return store(value, key)
        }
        
        XCTFail("Failed to cast")
    }
    
    var stubGETValue: ((String) -> Any)?
    
    func getValue<T: Decodable>(for key: String) throws -> T? {
        if let stubGETValue, let value = stubGETValue(key) as? T {
            return value
        }
        XCTFail("Failed to cast")
        return nil
    }
}

final class FakeStore: KeyValueStorageProtocol {
    private var dictionary: [String: Any] = [:]
    
    func store<T>(value: T, for key: String) throws where T : Encodable {
        dictionary[key] = value
    }
    
    func getValue<T>(for key: String) throws -> T? where T : Decodable {
        dictionary[key] as? T
    }
}
