import Combine
import LotteriesDomain

public final class LotteryListViewModel: ObservableObject {
    
    enum State {
        case idle, loading, loaded, error
    }
    
    @Published var state: State = .idle
    
    private let useCase: LotteryListUseCaseProtocol
    
    public init(useCase: LotteryListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func onAppear() {
        state = .loading
        fetchLotteries()
    }
}

private extension LotteryListViewModel {
    
    func fetchLotteries() {
        do {
            let result = try useCase.fetch()
            state = .loaded
        } catch {
            state = .error
            print(error) // TODO: Handle error state
        }
    }
}
