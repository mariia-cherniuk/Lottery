import Foundation
import LotteriesDomain

@testable import LotteriesFeature
final class MockLotteriesCoordinator: LotteriesCoordinating {
    
    var capturedLottery: Lottery?
    func showDetails(_ lottery: Lottery) {
        capturedLottery = lottery
    }
}
