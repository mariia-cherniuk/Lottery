import XCTest
import SwiftUI
import LotteriesDomain

@testable import LotteriesFeature

final class TicketViewModelTests: XCTestCase {

    func testWinningTicket() {
        let viewModel = TicketViewModel(lotteryTicket: .fixture(), lottery: .fixture())
       
        XCTAssertEqual(viewModel.message, "🎉 Congratulations! You have a winning ticket!")

        XCTAssertEqual(viewModel.ballViewModels.count, 6)
        
        XCTAssertEqual(viewModel.ballViewModels[0].number, 2)
        XCTAssertEqual(viewModel.ballViewModels[0].colour, Color.green)
        
        XCTAssertEqual(viewModel.ballViewModels[1].number, 3)
        XCTAssertEqual(viewModel.ballViewModels[1].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[2].number, 5)
        XCTAssertEqual(viewModel.ballViewModels[2].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[3].number, 7)
        XCTAssertEqual(viewModel.ballViewModels[3].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[4].number, 11)
        XCTAssertEqual(viewModel.ballViewModels[4].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[5].number, 13)
        XCTAssertEqual(viewModel.ballViewModels[5].colour, Color.gray)
    }
    
    func testLosingTicket() {
        let lottery = Lottery.fixture()
        let lotteryTicket = LotteryTicket.fixture(number1: 1, number2: 9)
        let viewModel = TicketViewModel(lotteryTicket: lotteryTicket, lottery: lottery)
       
        XCTAssertEqual(viewModel.message, "☹️ Your ticket didn't win. Better luck next time!")

        XCTAssertEqual(viewModel.ballViewModels.count, 6)
        
        XCTAssertEqual(viewModel.ballViewModels[0].number, 1)
        XCTAssertEqual(viewModel.ballViewModels[0].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[1].number, 9)
        XCTAssertEqual(viewModel.ballViewModels[1].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[2].number, 5)
        XCTAssertEqual(viewModel.ballViewModels[2].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[3].number, 7)
        XCTAssertEqual(viewModel.ballViewModels[3].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[4].number, 11)
        XCTAssertEqual(viewModel.ballViewModels[4].colour, Color.gray)
        
        XCTAssertEqual(viewModel.ballViewModels[5].number, 13)
        XCTAssertEqual(viewModel.ballViewModels[5].colour, Color.gray)
    }
}
