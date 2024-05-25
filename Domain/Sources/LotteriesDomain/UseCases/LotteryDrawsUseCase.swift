import Foundation
import NetworkManagement

public protocol LotteryDrawsUseCaseProtocol {
    func fetch() async throws -> LotteriesResponse
}

final class LotteryDrawsUseCase: LotteryDrawsUseCaseProtocol {
    
    private let path: String = "/mariia-cherniuk/Lottery/master/Resources/lotteries.json"
    private let dataLoader: DataLoading
    private let lotteriesStorage: LotteriesStorable
    private let transformer: LotteryDrawsTransformer
    
    init(dataLoader: DataLoading,
         lotteriesStorage: LotteriesStorable,
         transformer: LotteryDrawsTransformer = LotteryDrawsTransformer()) {
        self.dataLoader = dataLoader
        self.lotteriesStorage = lotteriesStorage
        self.transformer = transformer
    }
    
    func fetch() async throws -> LotteriesResponse {
        let data = try await dataLoader.fetch(resource: Resource(path: path, method: .GET))
        return try transformer.transform(data: data)
    }
}

final class LotteryDrawsTransformer {
    
    func transform(data: Data) throws -> LotteriesResponse {
        do {
            let decoded = try JSONDecoder().decode(LotteriesResponse.self, from: data)
            return decoded
        } catch {
            throw map(error: error)
        }
    }
    
    private func map(error: Error) -> DomainError {
        guard let error = error as? NetworkError else { return .other }
        switch error {
        case .notConnectedToInternet:
            return .notConnectedToInternet
        default:
            return .other
        }
    }
}
