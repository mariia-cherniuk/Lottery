import XCTest
import DesignLibrary

final class DrawDetailsScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func assertScreenVisible() -> Self {
        XCTAssertTrue(app.scrollViews[AccessibilityIdentifiers.DrawDetailsSceen.name].waitForExistence(timeout: 5))
        return self
    }
    
    func tapGenerateTicketsButton() {
        app.buttons[AccessibilityIdentifiers.DrawDetailsSceen.generateTickets].tap()
    }
}
