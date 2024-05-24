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
        } catch DomainError.unableToReadFromURL {
            state = .error(errorViewModel(message: "Unable to fetch lotteries."))
        } catch {
            //TODO: Handle other errors according to the specific requirements of the app
            state = .error(errorViewModel(message: "Smth went wrong, please try again."))
        }
    }
    
    func errorViewModel(message: String) -> ErrorViewModel {
        ErrorViewModel(title: "Oh no 😢", message: message, actionTitle: "Retry") { [weak self] in
            self?.onAppear()
        }
    }
}
