import LotteriesDomain
import LotteriesFeature
import SwiftUI

final class Coordinator: ObservableObject, LotteriesCoordinating {
    
    enum Destination: Hashable {
        case detail
    }
    
    @Published var destinations: [Destination] = []
    private let useCaseFactory: UseCaseFactory
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func showDetails() {
        destinations.append(.detail)
    }
}
