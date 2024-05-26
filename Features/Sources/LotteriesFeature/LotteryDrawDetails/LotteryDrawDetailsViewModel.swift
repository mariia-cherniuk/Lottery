import LotteriesDomain
import DesignLibrary
import SwiftUI

public final class LotteryDrawDetailsViewModel: ObservableObject {
    
    private struct Constant {
        static let resultBallColour = Color.red
        static let bonusBallColour = Color.yellow
        static let losingBallColour = Color.gray
    }
    
    private lazy var bonusBall = lottery.bonusBall
    
    private lazy var resultNumbers = [
        lottery.number1, lottery.number2, lottery.number3,
        lottery.number4, lottery.number5, lottery.number6
    ]
    
    private var results: [String] {
        resultNumbers + [bonusBall]
    }
    
    lazy var ballViewModels: [BallViewModel] = {
        let bonusBallViewModel = BallViewModel(number: bonusBall, colour: Constant.bonusBallColour)
        var ballViewModels: [BallViewModel] = resultNumbers.map { BallViewModel(number: $0, colour: Constant.resultBallColour) }
        ballViewModels.append(bonusBallViewModel)
        return ballViewModels
    }()
    
    @Published var tickets = [Ticket]()
    
    private let lottery: Lottery
    private let useCase: TicketGeneratorUseCasePtotocol
    
    public init(lottery: Lottery,
                useCase: TicketGeneratorUseCasePtotocol) {
        self.lottery = lottery
        self.useCase = useCase
    }
    
    func onGenerateTicket() {
        let generatedTicket = generateTicket()
        tickets.insert(generatedTicket, at: 0)
    }
}

private extension LotteryDrawDetailsViewModel {
    
    func generateTicket() -> Ticket {
        let numbers = useCase.generateTicket()
        let hasTicketWon = hasTicketWon(numbers)
        let ticketBalls = numbers.map(map(_:))
        return Ticket(hasWon: hasTicketWon, ballViewModels: ticketBalls)
    }
    
    func map(_ number: String) -> BallViewModel {
        let hasBallWon = results.contains(where: { $0 == number })
        let colour = hasBallWon ? Constant.resultBallColour : Constant.losingBallColour
        return BallViewModel(number: number, colour: colour)
    }
    
    func hasTicketWon( _ ticketNumbers: [String]) -> Bool {
        ///In this app, a ticket is considered a winner if it contains at least one number that match the lottery results
        return ticketNumbers.haveCommonElements(numberOfCummonElements: 1, array: results)
    }
}
