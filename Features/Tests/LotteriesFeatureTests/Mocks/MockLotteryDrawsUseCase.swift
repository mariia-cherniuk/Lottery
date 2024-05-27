import LotteriesDomain

struct MockError: Error {}

final class MockLotteryDrawsUseCase: LotteryDrawsUseCaseProtocol {
    
    var stubResponse: (() throws -> [Lottery])?
    var fetchWasCalled = false
    
    func fetch() throws -> [Lottery] {
        fetchWasCalled = true

        guard let response = try stubResponse?() else {
            throw MockError()
        }
        
        return response
    }
}
