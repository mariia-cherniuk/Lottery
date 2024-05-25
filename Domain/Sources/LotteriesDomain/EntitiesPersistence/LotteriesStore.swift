import Foundation
import Combine
import Storage

protocol LotteriesStorable {
    func fetchAll() throws -> [Lottery]
    func save(_ items: [Lottery]) throws
    func contains(_ item: Lottery) -> Bool
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
    
    func save(_ items: [Lottery]) throws {
        try storage.store(value: items, for: storeKey)
    }
    
    func contains(_ item: Lottery) -> Bool {
        let all = (try? fetchAll()) ?? []
        return all.contains(where: { $0.id == item.id })
    }
}
