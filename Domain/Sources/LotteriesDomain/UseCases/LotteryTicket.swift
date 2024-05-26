import Foundation

public class LotteryTicket {
    
    public lazy var hasWon: Bool = {
        ///In this app, a ticket is considered a winner if it contains at least one number that match the lottery results
        return numbers.haveCommonElements(numberOfCummonElements: 1, array: resultNumbers)
    }()
    
    public let numbers: [String]
    public let resultNumbers: [String]
    
    init(numbers: [String], resultNumbers: [String]) {
        self.numbers = numbers
        self.resultNumbers = resultNumbers
    }
    
    public func resultContains(_ number: String) -> Bool {
        resultNumbers.contains(where: { $0 == number })
    }
}
