import XCTest
import SwiftUI
import Combine

@testable import LotteriesFeature

final class LotteryDrawDetailsViewModelTests: XCTestCase {
    
    private var mockUseCase: MockTicketGeneratorUseCase!
    private var viewModel: LotteryDrawDetailsViewModel!
    
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockTicketGeneratorUseCase()
        viewModel = LotteryDrawDetailsViewModel(lottery: .fixture(), useCase: mockUseCase)
    }
    
    override func tearDown() {
        cancellables = []
        mockUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testBallViewModels() {
        XCTAssertEqual(viewModel.ballViewModels.count, 7)
        
        XCTAssertEqual(viewModel.ballViewModels[0].number, 2)
        XCTAssertEqual(viewModel.ballViewModels[0].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[1].number, 16)
        XCTAssertEqual(viewModel.ballViewModels[1].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[2].number, 23)
        XCTAssertEqual(viewModel.ballViewModels[2].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[3].number, 44)
        XCTAssertEqual(viewModel.ballViewModels[3].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[4].number, 47)
        XCTAssertEqual(viewModel.ballViewModels[4].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[5].number, 52)
        XCTAssertEqual(viewModel.ballViewModels[5].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[6].number, 14)
        XCTAssertEqual(viewModel.ballViewModels[6].colour, Color.yellow)
    }
    
    func testWhenOnGenerateTicket_ThenCallGenerateTicket() {
        viewModel.onGenerateTicket()
        XCTAssertTrue(mockUseCase.generateTicketWasCalled)
    }
    
    func testWhenOnGenerateTicket_ThenPublishValue() {
        mockUseCase.stubLotteryTicket = .fixture()
        
        var capturedTickets = [TicketViewModel]()
        viewModel.$tickets
            .sink { tickets in
                capturedTickets = tickets
            }
            .store(in: &cancellables)
        
        viewModel.onGenerateTicket()
        
        XCTAssertEqual(capturedTickets.count, 1)
    }
}
