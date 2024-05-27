import DesignLibrary
import LotteriesDomain
import SwiftUI

final class TicketViewModel {
    
    private(set) lazy var message: String = {
        lotteryTicket.hasWon(for: lottery) ?
        "🎉 Congratulations! You have a winning ticket!" :
        "☹️ Your ticket didn't win. Better luck next time!"
    }()
    
    private(set) lazy var ballViewModels: [BallViewModel] = {
        lotteryTicket.numbers.map(map(_:))
    }()
    
    let id = UUID()
    private let lotteryTicket: LotteryTicket
    private let lottery: Lottery
    
    init(lotteryTicket: LotteryTicket, lottery: Lottery) {
        self.lotteryTicket = lotteryTicket
        self.lottery = lottery
    }
}

private extension TicketViewModel {
   
    func map(_ number: Int) -> BallViewModel {
        let hasBallWon = lottery.numbersAndBonusBall.contains(where: { $0 == number })
        let colour = hasBallWon ? Color.green : Color.gray
        return BallViewModel(number: number, colour: colour)
    }
}
