import LotteriesDomain

final class MockTicketGeneratorUseCase: TicketGeneratorUseCasePtotocol {
    
    var stubLotteryTicket: LotteryTicket?
    var generateTicketWasCalled = false
    
    func generateTicket() -> LotteryTicket {
        generateTicketWasCalled = true
        
        guard let lotteryTicket = stubLotteryTicket else {
            return LotteryTicket(numbers: [])
        }
        return lotteryTicket
    }
}
