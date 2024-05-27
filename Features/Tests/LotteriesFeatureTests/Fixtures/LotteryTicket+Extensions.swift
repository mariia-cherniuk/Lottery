import LotteriesDomain

extension LotteryTicket {
    
    static func fixture(number2: Int = 2) -> LotteryTicket {
        LotteryTicket(numbers: [1, number2, 5, 7, 11, 13])
    }
}
