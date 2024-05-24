import Foundation
import JSONService

public protocol LotteryDrawsUseCaseProtocol {
    func fetch() throws -> LotteriesResponse
}

final class LotteryDrawsUseCase: LotteryDrawsUseCaseProtocol {
    
    private let url: URL?
    private let jsonService: JSONServiceProtocol
    
    init(jsonService: JSONServiceProtocol,
         url: URL? = Bundle.module.url(forResource: "lotteries", withExtension: "json")) {
        self.jsonService = jsonService
        self.url = url
    }
    
    func fetch() throws -> LotteriesResponse {
        guard let url else { throw DomainError.resourceCouldNotBeFound }
        
        do {
            return try jsonService.fetch(from: url)
        } catch {
            throw map(error: error)
        }
    }
}


private extension LotteryDrawsUseCase {
    
    private func map(error: Error) -> DomainError {
        guard let error = error as? JSONError else { return .other }
        switch error {
        case .unableToReadFromURL:
            return .unableToReadFromURL
        default:
            return .other
        }
    }
}
