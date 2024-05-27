import Foundation

public class LotteryTicket {
    
    public let numbers: [Int]
    
    init(numbers: [Int]) {
        self.numbers = numbers
    }
    
    public func hasWon(for result: Lottery) -> Bool {
        ///In this app, a ticket is considered a winner if it contain
        numbers.haveCommonElements(numberOfCummonElements: 1, array: result.numbersAndBonusBall)
    }
}
