import Foundation

public class LotteryTicket {
    
    public let numbers: [Int]
    
    init(numbers: [Int]) {
        self.numbers = numbers
    }
    
    public func hasWon(for lottery: Lottery) -> Bool {
        ///In this app, a ticket is considered a winner if it contain
        numbers.haveCommonElements(numberOfCummonElements: 1, array: lottery.numbersAndBonusBall)
    }
}
