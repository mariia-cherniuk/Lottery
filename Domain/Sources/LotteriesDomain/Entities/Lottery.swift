public struct Lottery: Decodable {
    
    enum CodingKeys: String, CodingKey {
        ///Using dashes in variable names is generally discouraged as it does not align with Swift's naming conventions
        case id = "id"
        case number1 = "number1"
        case number2 = "number2"
        case number3 = "number3"
        case number4 = "number4"
        case number5 = "number5"
        case number6 = "number6"
        case bonusBall = "bonus-ball"
        case topPrize = "topPrize"
    }
    
    let id: String
    let number1: String
    let number2: String
    let number3: String
    let number4: String
    let number5: String
    let number6: String
    let bonusBall: String
    let topPrize: Int // TODO: Double check type and max value
}

public struct LotteriesResponse: Decodable {
    let draws: [Lottery]
}
