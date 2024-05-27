import XCTest

@testable import LotteriesFeature

final class LotteryDrawCellViewModelTests: XCTestCase {
    
    func testLotteryDraw() {
        let lotteryDraw = LotteryDrawCellViewModel(lottery: .fixture(id: "id-1", drawDate: Date.fixture()))
        XCTAssertEqual(lotteryDraw.id, "id-1")
        XCTAssertEqual(lotteryDraw.date, "15 May 2023")
        XCTAssertEqual(lotteryDraw.topPrize, "£40,000,000")
    }
}
