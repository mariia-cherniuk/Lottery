import JSONService

public final class UseCaseFactory {
    
    private let jsonService: JSONServiceProtocol
    
    public init(jsonService: JSONServiceProtocol) {
        self.jsonService = jsonService
    }
    
    public func makeLotteryListUseCase() -> LotteryListUseCaseProtocol {
        LotteryListUseCase(jsonService: jsonService)
    }
}
