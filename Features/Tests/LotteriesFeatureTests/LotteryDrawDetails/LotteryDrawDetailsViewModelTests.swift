import XCTest
import SwiftUI

@testable import LotteriesFeature

final class LotteryDrawDetailsViewModelTests: XCTestCase {
 
    private let viewModel = LotteryDrawDetailsViewModel(lottery: .fixture())
    
    func testBallViewModels() {
        XCTAssertEqual(viewModel.ballViewModels.count, 7)
        
        XCTAssertEqual(viewModel.ballViewModels[0].number, "2")
        XCTAssertEqual(viewModel.ballViewModels[0].colour, Color.red)
        
        XCTAssertEqual(viewModel.ballViewModels[1].number, "16")
        XCTAssertEqual(viewModel.ballViewModels[1].colour, Color.red)
        
        XCTAssertEqual(viewModel.ballViewModels[2].number, "23")
        XCTAssertEqual(viewModel.ballViewModels[2].colour, Color.red)
        
        XCTAssertEqual(viewModel.ballViewModels[3].number, "44")
        XCTAssertEqual(viewModel.ballViewModels[3].colour, Color.red)
        
        XCTAssertEqual(viewModel.ballViewModels[4].number, "47")
        XCTAssertEqual(viewModel.ballViewModels[4].colour, Color.red)
        
        XCTAssertEqual(viewModel.ballViewModels[5].number, "52")
        XCTAssertEqual(viewModel.ballViewModels[5].colour, Color.red)
        
        XCTAssertEqual(viewModel.ballViewModels[6].number, "14")
        XCTAssertEqual(viewModel.ballViewModels[6].colour, Color.yellow)
    }
}
