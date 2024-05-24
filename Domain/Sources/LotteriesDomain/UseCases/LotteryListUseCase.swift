import JSONService

public protocol LotteryListUseCaseProtocol {
    func fetch()
}

final class LotteryListUseCase: LotteryListUseCaseProtocol {
    
    private let jsonService: JSONServiceProtocol
    
    init(jsonService: JSONServiceProtocol) {
        self.jsonService = jsonService
    }
    
    func fetch() {}
}
