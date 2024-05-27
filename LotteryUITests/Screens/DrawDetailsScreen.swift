import XCTest
import DesignLibrary

final class DrawDetailsScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func assertScreenVisible() -> Self {
        XCTAssertTrue(app.scrollViews[AccessibilityIdentifiers.DrawDetailsScreen.name].waitForExistence(timeout: 5))
        return self
    }
    
    func tapGenerateTicketsButtonTwice() {
        let generateTicketsButton = app.buttons[AccessibilityIdentifiers.DrawDetailsScreen.generateTickets]
        generateTicketsButton.tap()
        generateTicketsButton.tap()
    }
}
