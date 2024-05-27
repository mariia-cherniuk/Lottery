import LotteriesDomain

extension LotteryTicket {
    
    static func fixture(lastNumber: Int = 13) -> LotteryTicket {
        LotteryTicket(numbers: [1, 2, 5, 7, 11, lastNumber])
    }
}
