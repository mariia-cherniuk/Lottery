import Combine
import LotteriesDomain
import DesignLibrary

@MainActor
public final class LotteryDrawsViewModel: ObservableObject {
    
    enum State {
        case idle, loading, loaded([LotteryDrawCellViewModel]), error(ErrorViewModel)
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
        
        Task {
            await fetchLotteries()
        }
    }
    
    func onTap(_ lottery: Lottery) {
        coordinator.showDetails(lottery)
    }
    
    func onTabbedTap() {
        guard case .loaded(let cellViewModels) = state else { return }
        coordinator.showTabbedDetails(cellViewModels.map(\.lottery))
    }
}

private extension LotteryDrawsViewModel {
    
    func fetchLotteries() async {
        do {
            let draws = try await useCase.fetch()
            
            if draws.isEmpty {
                state = .error(errorViewModel(message: "The content you requested is currently empty."))
            } else {
                state = .loaded(lotteryDraws(from: draws))
            }
        } catch {
            state = .error(errorViewModel(message: "Smth went wrong, please try again."))
        }
    }
    
    func errorViewModel(message: String) -> ErrorViewModel {
        ErrorViewModel(title: "Oh no 😢", message: message, actionTitle: "Retry") { [weak self] in
            self?.onAppear()
        }
    }
    
    func lotteryDraws(from lotteries: [Lottery]) -> [LotteryDrawCellViewModel] {
        lotteries.map { LotteryDrawCellViewModel(lottery: $0) }
    }
}
