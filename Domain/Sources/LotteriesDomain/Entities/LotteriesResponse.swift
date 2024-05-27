public struct LotteriesResponse: Codable {
    
    public let draws: [Lottery]
    
    public init(draws: [Lottery]) {
        self.draws = draws
    }
}
