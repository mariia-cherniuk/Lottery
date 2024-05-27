public protocol TicketGeneratorUseCasePtotocol {
    func generateTicket() -> LotteryTicket
}

final class TicketGeneratorUseCase: TicketGeneratorUseCasePtotocol {
    
    private struct Constant {
        static let minTicketNumber = 1
        static let maxTicketNumber = 47
        static let numbersAmount = 6
    }
    /// generator is var because it requires inout &argument
    private var generator: RandomNumberGenerator
    
    init(generator: RandomNumberGenerator) {
        self.generator = generator
    }
    
    func generateTicket() -> LotteryTicket {
        let numbers = Array(Constant.minTicketNumber ... Constant.maxTicketNumber)
            .shuffled(using: &generator)
            .prefix(Constant.numbersAmount)
            .sorted()
        
        return LotteryTicket(numbers: numbers)
    }
}
