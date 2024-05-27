import Foundation
import NetworkManagement
import Formatters

public protocol LotteryDrawsUseCaseProtocol {
    func fetch() async throws -> [Lottery]
}

final class LotteryDrawsUseCase: LotteryDrawsUseCaseProtocol {
    
    private let path: String = "/mariia-cherniuk/Lottery/master/Resources/lotteries.json"
    private let dataLoader: DataLoading
    private let lotteriesStorage: LotteriesStorable

    init(dataLoader: DataLoading,
         lotteriesStorage: LotteriesStorable) {
        self.dataLoader = dataLoader
        self.lotteriesStorage = lotteriesStorage
    }
    
    func fetch() async throws -> [Lottery] {
        do {
            let data = try await dataLoader.fetch(resource: Resource(path: path, method: .GET))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.drawDateFormatter)
            let response = try decoder.decode(LotteriesResponse.self, from: data)
            let draws = response.draws
            try? lotteriesStorage.save(draws) //TODO: ADD logger
            return draws
        } catch NetworkError.notConnectedToInternet {
            return try lotteriesStorage.fetchAll()
        } catch {
            throw DomainError.other
        }
    }
}
