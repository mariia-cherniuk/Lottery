import LotteriesDomain

public final class LotteryDrawDetailsViewModel {
    
    lazy var numbers: [String] = {
        [lottery.number1, lottery.number2, lottery.number3, lottery.number4, lottery.number5, lottery.number6]
    }()
    
    private let lottery: Lottery
    
    public init(lottery: Lottery) {
        self.lottery = lottery
    }
}
