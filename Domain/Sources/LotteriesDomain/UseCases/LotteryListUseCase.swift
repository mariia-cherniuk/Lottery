import Foundation
import JSONService

public protocol LotteryListUseCaseProtocol {
    func fetch() throws -> LotteriesResponse
}

final class LotteryListUseCase: LotteryListUseCaseProtocol {
    
    //TODO: Avoid force unwrapping; instead, throw an error and handle it within the view model
    private let url = Bundle.module.url(forResource: "lotteries", withExtension: "json")!
    private let jsonService: JSONServiceProtocol
    
    init(jsonService: JSONServiceProtocol) {
        self.jsonService = jsonService
    }
    
    func fetch() throws -> LotteriesResponse {
        try jsonService.fetch(from: url)
    }
}
