import XCTest

@testable import LotteriesDomain

final class TicketGeneratorUseCaseTests: XCTestCase {

    private var useCase: TicketGeneratorUseCase!
    private var sequentialNumberGenerator: SequentialNumberGenerator!
    
    override func setUp() {
        super.setUp()
        sequentialNumberGenerator = SequentialNumberGenerator()
        useCase = TicketGeneratorUseCase(generator: sequentialNumberGenerator)
    }
    
    override func tearDown() {
        sequentialNumberGenerator = nil
        useCase = nil
        super.tearDown()
    }

    func testWhenGenerateTicketIsCalled_ThenTicketContainsCorrectNumbers() {
        let ticket = useCase.generateTicket()
        
        XCTAssertEqual(ticket, LotteryTicket(numbers: [1, 2, 3, 4, 5, 6]))
    }
}
