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
    
    func assertTicketDoesNotExist() -> Self {
        let ticket = app.staticTexts[AccessibilityIdentifiers.DrawDetailsScreen.ticket(at: 0)]
        XCTAssertFalse(ticket.exists, "The ticket should not exist")
        return self
    }
    
    func assertTicketExist() {
        let ticket = app.staticTexts[AccessibilityIdentifiers.DrawDetailsScreen.ticket(at: 0)]
        XCTAssertTrue(ticket.exists, "The ticket should exist")
    }
    
    func tapGenerateTickets() -> Self {
        let generateTicketsButton = app.buttons[AccessibilityIdentifiers.DrawDetailsScreen.generateTickets]
        generateTicketsButton.tap()
        return self
    }
}
