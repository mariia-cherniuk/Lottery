import XCTest

final class DrawDetailsScreenTests: XCTestCase {

    func testCanGenerateAndDisplayTickets() {
        navigateToDrawDetails()
            .assertTicketDoesNotExist()
            .tapGenerateTickets()
            .assertTicketExist()
    }
    
    func testCanSwipeBetweenDetails() {
        navigateToDrawDetails()
            .assertSwipe()
    }
    
    private func navigateToDrawDetails() -> DrawDetailsScreen {
        let app = XCUIApplication()
        app.launch()
        
        let screen = DrawsScreen(app: app)
        
        return screen.assertScreenVisible()
            .tapFirstDraw()
            .assertTabbedScreenVisible()
    }
}
