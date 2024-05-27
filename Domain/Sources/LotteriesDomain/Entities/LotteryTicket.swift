import Foundation

public class LotteryTicket {
    
    public let numbers: [Int]
    
    public init(numbers: [Int]) {
        self.numbers = numbers
    }
    
    public func hasWon(for lottery: Lottery) -> Bool {
        ///In this app, a ticket is considered a winner if it contains at least one number that match the lottery result
        numbers.haveCommonElements(numberOfCummonElements: 1, array: lottery.numbersAndBonusBall)
    }
}
