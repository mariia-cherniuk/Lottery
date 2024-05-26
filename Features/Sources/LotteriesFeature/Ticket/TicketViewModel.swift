import DesignLibrary
import LotteriesDomain
import SwiftUI

final class TicketViewModel {
    
    var message: String {
        lotteryTicket.hasWon ?
        "🎉 Congratulations! You have a winning ticket!" :
        "☹️ Your ticket didn't win. Better luck next time!"
    }
    
    var ballViewModels: [BallViewModel] {
        lotteryTicket.numbers.map(map(_:))
    }
    
    let id = UUID()
    private let lotteryTicket: LotteryTicket
    
    init(lotteryTicket: LotteryTicket) {
        self.lotteryTicket = lotteryTicket
    }
}

private extension TicketViewModel {
   
    func map(_ number: String) -> BallViewModel {
        let hasBallWon = lotteryTicket.resultContains(number)
        let colour = hasBallWon ? Color.red : Color.gray
        return BallViewModel(number: number, colour: colour)
    }
}
