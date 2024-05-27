import LotteriesDomain

extension LotteryTicket {
    
    static func fixture(number1: Int = 2, number2: Int = 3) -> LotteryTicket {
        LotteryTicket(numbers: [number1, number2, 5, 7, 11, 13])
    }
}
