import LotteriesDomain
import SwiftUI

final class Coordinator: ObservableObject {
    
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
