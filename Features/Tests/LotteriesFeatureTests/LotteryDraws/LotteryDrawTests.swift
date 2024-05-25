import XCTest

@testable import LotteriesFeature

final class LotteryDrawTests: XCTestCase {
    
    func testLotteryDraw() {
        let lotteryDraw = LotteryDraw(lottery: .fixture(id: "id-1", drawDate: "2024-05-15"))
        XCTAssertEqual(lotteryDraw.id, "id-1")
        XCTAssertEqual(lotteryDraw.date, "15 May 2024")
    }
}
