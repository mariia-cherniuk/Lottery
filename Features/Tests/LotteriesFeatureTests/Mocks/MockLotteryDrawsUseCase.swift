import LotteriesDomain

struct MockError: Error {}

final class MockLotteryDrawsUseCase: LotteryDrawsUseCaseProtocol {
    
    var stubResponse: (() throws -> LotteriesResponse)?
    var fetchWasCalled = false
    
    func fetch() throws -> LotteriesResponse {
        fetchWasCalled = true

        guard let response = try stubResponse?() else {
            throw MockError()
        }
        
        return response
    }
}
