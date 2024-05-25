import LotteriesDomain
import DesignLibrary
import SwiftUI

public final class LotteryDrawDetailsViewModel {
    
    lazy var ballViewModels: [BallViewModel] = {
        let numbers = [lottery.number1, lottery.number2, lottery.number3, lottery.number4, lottery.number5, lottery.number6]
        let bonusBallViewModel = BallViewModel(number: lottery.bonusBall, colour: Color.yellow)
        var ballViewModels: [BallViewModel] = numbers.map { BallViewModel(number: $0, colour: Color.red) }
        ballViewModels.append(bonusBallViewModel)
        return ballViewModels
    }()
    
    private let lottery: Lottery
    
    public init(lottery: Lottery) {
        self.lottery = lottery
    }
}
