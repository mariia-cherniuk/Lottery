import Foundation

@testable import LotteriesDomain
final class MockLotteriesStorage: LotteriesStorable {
   
    var fetchWasCalled = false
    func fetchAll() throws -> [Lottery] {
        fetchWasCalled = true
        return []
    }
    
    var saveWasCalled = false
    func save(_ items: [Lottery]) throws {
        saveWasCalled = true
    }
    
    var stubContainsLottery = false
    func contains(_ item: Lottery) -> Bool {
        stubContainsLottery
    }
}
