import XCTest

@testable import LotteriesFeature

final class LotteryDrawTests: XCTestCase {
    
    func testLotteryDraw() {
        let lotteryDraw = LotteryDraw(lottery: .fixture(id: "id-1", drawDate: Date.fixture()))
        XCTAssertEqual(lotteryDraw.id, "id-1")
        XCTAssertEqual(lotteryDraw.date, "15 May 2023")
    }
}
