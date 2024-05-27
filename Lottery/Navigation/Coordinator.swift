import LotteriesDomain
import LotteriesFeature
import SwiftUI

final class Coordinator: ObservableObject, LotteriesCoordinating {
    
    enum Destination: Hashable {
        case detail(Lottery)
        case tabbedDetail([Lottery])
    }
    
    @Published var destinations: [Destination] = []
    private let useCaseFactory: UseCaseFactory
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func showDetails(_ lottery: Lottery) {
        destinations.append(.detail(lottery))
    }
    
    func showTabbedDetails(_ lotteries: [Lottery]) {
        destinations.append(.tabbedDetail(lotteries))
    }
    
    func lotteryDrawDetailsView(for lottery: Lottery) -> some View {
        LotteryDrawDetailsView(viewModel: makeLotteryDrawDetailsViewModel(lottery))
    }
    
    func tabDrawDetailsView(for lotteries: [Lottery]) -> some View {
        TabDrawDetailsView(viewModels: lotteries.map { makeLotteryDrawDetailsViewModel($0) })
    }
}

private extension Coordinator {
    
    func makeLotteryDrawDetailsViewModel(_ lottery: Lottery) -> LotteryDrawDetailsViewModel {
        let useCase = useCaseFactory.ticketGeneratorUseCase()
        return LotteryDrawDetailsViewModel(lottery: lottery, useCase: useCase)
    }
}
