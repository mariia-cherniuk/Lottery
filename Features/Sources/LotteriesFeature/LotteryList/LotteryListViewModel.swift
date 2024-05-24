import LotteriesDomain

public final class LotteryListViewModel {
    
    private let useCase: LotteryListUseCaseProtocol
    
    public init(useCase: LotteryListUseCaseProtocol) {
        self.useCase = useCase
    }
}
