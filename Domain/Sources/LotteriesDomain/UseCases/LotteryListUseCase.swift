import Foundation
import JSONService

public protocol LotteryListUseCaseProtocol {
    func fetch() throws -> LotteriesResponse
}

final class LotteryListUseCase: LotteryListUseCaseProtocol {
    
    private let url = Bundle.module.url(forResource: "lotteries", withExtension: "json")
    private let jsonService: JSONServiceProtocol
    
    init(jsonService: JSONServiceProtocol) {
        self.jsonService = jsonService
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


private extension LotteryListUseCase {
    
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
