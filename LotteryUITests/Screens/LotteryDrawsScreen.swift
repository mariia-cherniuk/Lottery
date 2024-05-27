import XCTest
import DesignLibrary

final class LotteryDrawsScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func assertScreenVisible() -> Self {
        XCTAssertTrue(app.scrollViews[AccessibilityIdentifiers.DrawsScreen.name].waitForExistence(timeout: 5))
        return self
    }
    
    func tapFirstDraw() -> TabDrawDetailsScreen {
        app.buttons[AccessibilityIdentifiers.DrawsScreen.draw(at: 0)].tap()
        
        ///Return a new screen, as this action navigates to the next screen
        return TabDrawDetailsScreen(app: app)
    }
}
