import XCTest
import DesignLibrary

final class DrawDetailsScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func assertTabbedScreenVisible() -> Self {
        XCTAssertTrue(app.collectionViews[AccessibilityIdentifiers.DrawDetailsScreen.tabbedScreenName].waitForExistence(timeout: 5))
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
    
    func assertSwipe() {
        let firstTab = app.scrollViews[AccessibilityIdentifiers.DrawDetailsScreen.tab(at: 1)]
        XCTAssertTrue(firstTab.exists, "The first tab should be visible")
        
        firstTab.swipeLeft()
        
        let secondTab = app.scrollViews[AccessibilityIdentifiers.DrawDetailsScreen.tab(at: 2)]
        XCTAssertTrue(secondTab.exists, "The second tab should be visible after swiping left from the first tab")
        
        secondTab.swipeRight()
        XCTAssertTrue(firstTab.exists, "The first tab should be visible after swiping right from the second tab")
    }
    
    func tapGenerateTickets() -> Self {
        let generateTicketsButton = app.buttons[AccessibilityIdentifiers.DrawDetailsScreen.generateTickets]
        generateTicketsButton.tap()
        return self
    }
}
