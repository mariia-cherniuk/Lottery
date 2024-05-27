import XCTest

final class DrawsScreenTests: XCTestCase {
    
    func testCanNavigateToDrawDetails() {
        let app = XCUIApplication()
        app.launch()
        
        let screen = LotteryDrawsScreen(app: app)
        
        screen.assertScreenVisible()
            .tapFirstDraw()
            .assertTabbedScreenVisible()
    }
}
