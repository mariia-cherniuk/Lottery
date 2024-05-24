import LotteriesDomain
import SwiftUI

final class Coordinator: ObservableObject {
    
    enum Destination: Hashable {
        case detail(Int)
    }
    
    @Published var destinations: [Destination] = []
    private let useCaseFactory: UseCaseFactory
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func showDetails(id: Int) {
        destinations.append(.detail(id))
    }
}
