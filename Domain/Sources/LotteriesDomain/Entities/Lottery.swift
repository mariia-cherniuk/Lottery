public struct Lottery: Decodable {
    
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
    public let drawDate: String
    public let number1: String
    public let number2: String
    public let number3: String
    public let number4: String
    public let number5: String
    public let number6: String
    public let bonusBall: String
    public let topPrize: Int // TODO: Double check type and max value
    
    public init(id: String, drawDate: String, number1: String, number2: String, number3: String, number4: String, number5: String, number6: String, bonusBall: String, topPrize: Int) {
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

public struct LotteriesResponse: Decodable {
    
    public let draws: [Lottery]
    
    public init(draws: [Lottery]) {
        self.draws = draws
    }
}

