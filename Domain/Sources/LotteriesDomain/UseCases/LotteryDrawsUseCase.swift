import Foundation
import NetworkManagement

public protocol LotteryDrawsUseCaseProtocol {
    func fetch() async throws -> LotteriesResponse
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
    
    func fetch() async throws -> LotteriesResponse {
        do {
            let data = try await dataLoader.fetch(resource: Resource(path: path, method: .GET))
            return try JSONDecoder().decode(LotteriesResponse.self, from: data)
        } catch NetworkError.notConnectedToInternet {
            let lotteries = try lotteriesStorage.fetchAll()
            return LotteriesResponse(draws: lotteries)
        } catch {
            throw DomainError.other
        }
    }
}
