import Combine
import LotteriesDomain
import DesignLibrary

@MainActor
public final class LotteryDrawsViewModel: ObservableObject {
    
    enum State {
        case idle, loading, loaded([LotteryDraw]), error(ErrorViewModel)
    }
    
    @Published var state: State = .idle
    
    private let useCase: LotteryDrawsUseCaseProtocol
    private let coordinator: LotteriesCoordinating
    
    public init(useCase: LotteryDrawsUseCaseProtocol, coordinator: LotteriesCoordinating) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func onAppear() {
        state = .loading
        fetchLotteries()
    }
    
    func onTapLotteryDraw() {
        coordinator.showDetails()
    }
}

private extension LotteryDrawsViewModel {
    
    func fetchLotteries() {
        do {
            let result = try useCase.fetch()
            state = .loaded(lotteryDraws(from: result.draws) )
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
    
    func lotteryDraws(from lotteries: [Lottery]) -> [LotteryDraw] {
        lotteries.map { LotteryDraw(draw: $0) }
    }
}
