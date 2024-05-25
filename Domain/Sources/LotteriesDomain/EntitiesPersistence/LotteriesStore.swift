import Foundation
import Combine
import Storage

protocol LotteriesStorable {
    func fetchAll() throws -> [Lottery]
    func save(character: Lottery) throws
    func contains(character: Lottery) -> Bool
}

final class LotteriesStore: LotteriesStorable {
    
    private(set) var storeKey: String
    private let storage: KeyValueStorageProtocol
    
    init(storage: KeyValueStorageProtocol, storeKey: String = "lotteries-store") {
        self.storage = storage
        self.storeKey = storeKey
    }
    
    func fetchAll() throws -> [Lottery] {
        try storage.getValue(for: storeKey) ?? []
    }
    
    func save(character: Lottery) throws {
        var all = try fetchAll()
        all.insert(character, at: 0)
        try storage.store(value: all, for: storeKey)
    }
    
    func contains(character: Lottery) -> Bool {
        let all = (try? fetchAll()) ?? []
        return all.contains(where: { $0.id == character.id })
    }
}
