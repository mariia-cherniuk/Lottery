import Foundation
import NetworkManagement
import Formatters
import Logger
import OSLog

public protocol LotteryDrawsUseCaseProtocol {
    func fetch() async throws -> [Lottery]
}

final class LotteryDrawsUseCase: LotteryDrawsUseCaseProtocol {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.drawDateFormatter)
        return decoder
    }()
    
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
            let response = try jsonDecoder.decode(LotteriesResponse.self, from: data)
            let draws = response.draws
            save(draws)
            return draws
        } catch NetworkError.notConnectedToInternet {
            return try lotteriesStorage.fetchAll()
        } catch {
            throw DomainError.other
        }
    }
}

private extension LotteryDrawsUseCase {
    
    func save(_ draws: [Lottery]) {
        do {
            try lotteriesStorage.save(draws)
        } catch {
            Logger.sharedLogger.info("Error description:\n\(error)")
        }
    }
}
