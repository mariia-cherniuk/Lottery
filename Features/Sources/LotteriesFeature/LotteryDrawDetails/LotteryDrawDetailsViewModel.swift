import LotteriesDomain
import DesignLibrary
import SwiftUI

public final class LotteryDrawDetailsViewModel: ObservableObject {
    
    private struct Constant {
        static let resultBallColour = Color.green
        static let bonusBallColour = Color.yellow
    }
    
    lazy var ballViewModels: [BallViewModel] = {
        generateResultBallViewModels()
    }()
    
    @Published var tickets = [TicketViewModel]()
    
    private let lottery: Lottery
    private let useCase: TicketGeneratorUseCasePtotocol
    
    public init(lottery: Lottery, useCase: TicketGeneratorUseCasePtotocol) {
        self.lottery = lottery
        self.useCase = useCase
    }
    
    func onGenerateTicket() {
        generateLotteryTicket()
    }
}

private extension LotteryDrawDetailsViewModel {
    
    func generateResultBallViewModels() -> [BallViewModel] {
        let bonusBallViewModel = BallViewModel(number: lottery.bonusBall, colour: Constant.bonusBallColour)
        var ballViewModels: [BallViewModel] = lottery.numbers.map { BallViewModel(number: $0, colour: Constant.resultBallColour) }
        ballViewModels.append(bonusBallViewModel)
        return ballViewModels
    }
    
    func generateLotteryTicket() {
        let lotteryTicket = useCase.generateTicket()
        let ticketViewModel = TicketViewModel(lotteryTicket: lotteryTicket, lottery: lottery)
        tickets.insert(ticketViewModel, at: 0)
    }
}
