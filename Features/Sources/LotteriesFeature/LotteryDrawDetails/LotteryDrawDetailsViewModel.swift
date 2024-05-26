import LotteriesDomain
import DesignLibrary
import SwiftUI

public final class LotteryDrawDetailsViewModel: ObservableObject {
    
    private lazy var resultNumbers = [lottery.number1, lottery.number2, lottery.number3, lottery.number4, lottery.number5, lottery.number6]
    
    lazy var ballViewModels: [BallViewModel] = {
        let bonusBallViewModel = BallViewModel(number: lottery.bonusBall, colour: Color.yellow)
        var ballViewModels: [BallViewModel] = resultNumbers.map { BallViewModel(number: $0, colour: Color.red) }
        ballViewModels.append(bonusBallViewModel)
        return ballViewModels
    }()
    
    @Published var tickets = [Ticket]()
    
    private let lottery: Lottery
    
    public init(lottery: Lottery) {
        self.lottery = lottery
    }
    
    func onGenerateTicket() {
        let newTicket = Ticket(hasWon: true, ballViewModels: ballViewModels)
        tickets.insert(newTicket, at: 0)
    }
}
