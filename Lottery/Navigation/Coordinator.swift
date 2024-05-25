import LotteriesDomain
import LotteriesFeature
import SwiftUI

final class Coordinator: ObservableObject, LotteriesCoordinating {
    
    enum Destination: Hashable {
        case detail(LotteryDraw)
    }
    
    @Published var destinations: [Destination] = []
    private let useCaseFactory: UseCaseFactory
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func showDetails(_ lotteryDraw: LotteryDraw) {
        destinations.append(.detail(lotteryDraw))
    }
}
