import Combine
import LotteriesDomain
import DesignLibrary

@MainActor
public final class LotteryListViewModel: ObservableObject {
    
    enum State {
        case idle, loading, loaded, error(ErrorViewModel)
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
            state = .error(errorViewModel(message: error.localizedDescription))
            print(error) // TODO: Handle error state
        }
    }
    
    func errorViewModel(message: String) -> ErrorViewModel {
        ErrorViewModel(title: "Oh no 😢", message: message, actionTitle: "Retry") { [weak self] in
            self?.onAppear()
        }
    }
}
