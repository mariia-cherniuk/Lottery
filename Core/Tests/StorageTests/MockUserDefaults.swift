import Foundation
@testable import Storage

final class MockUserDefaults: UserDefaults {
    
    var store = [String: Any]()
    
    override func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    override func data(forKey defaultName: String) -> Data? {
        return store[defaultName] as? Data
    }
}
