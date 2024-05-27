import ProppertyWrappers
import Foundation

public struct Lottery: Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        ///Using dashes in variable names is generally discouraged as it does not align with Swift's naming conventions
        case id = "id"
        case drawDate = "drawDate"
        case number1 = "number1"
        case number2 = "number2"
        case number3 = "number3"
        case number4 = "number4"
        case number5 = "number5"
        case number6 = "number6"
        case bonusBall = "bonus-ball"
        case topPrize = "topPrize"
    }
    
    public let id: String
    public let drawDate: Date
    
    @StringToInt public var number1: Int
    @StringToInt public var number2: Int
    @StringToInt public var number3: Int
    @StringToInt public var number4: Int
    @StringToInt public var number5: Int
    @StringToInt public var number6: Int
    @StringToInt public var bonusBall: Int
    
    public let topPrize: Int
    
    public init(id: String, drawDate: Date, number1: Int, number2: Int, number3: Int, number4: Int, number5: Int, number6: Int, bonusBall: Int, topPrize: Int) {
        self.id = id
        self.drawDate = drawDate
        self.number1 = number1
        self.number2 = number2
        self.number3 = number3
        self.number4 = number4
        self.number5 = number5
        self.number6 = number6
        self.bonusBall = bonusBall
        self.topPrize = topPrize
    }
}

extension Lottery {
    
    public var numbersAndBonusBall: [Int] {
        [number1, number2, number3, number4, number5, number6, bonusBall]
    }
    
    public var numbers: [Int] {
        [number1, number2, number3, number4, number5, number6]
    }
}
