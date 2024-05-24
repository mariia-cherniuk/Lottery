import LotteriesDomain

public final class LotteryListViewModel {
    
    private let useCase: LotteryListUseCaseProtocol
    
    public init(useCase: LotteryListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func onAppear() {
        fetchLotteries()
    }
}

private extension LotteryListViewModel {
    
    func fetchLotteries() {
        do {
            let result = try useCase.fetch()
            print(result)
        } catch {
            print(error) // TODO: Handle error state
        }
    }
}
