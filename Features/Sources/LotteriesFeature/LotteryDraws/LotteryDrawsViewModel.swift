import Combine
import LotteriesDomain
import DesignLibrary

@MainActor
public final class LotteryDrawsViewModel: ObservableObject {
    
    enum State {
        case idle, loading, loaded, error(ErrorViewModel)
    }
    
    @Published var state: State = .idle
    
    private let useCase: LotteryDrawsUseCaseProtocol
    
    public init(useCase: LotteryDrawsUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func onAppear() {
        state = .loading
        fetchLotteries()
    }
}

private extension LotteryDrawsViewModel {
    
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
