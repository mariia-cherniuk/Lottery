import XCTest

final class DrawDetailsScreenTests: XCTestCase {

    func testCanGenerateAndDisplayTickets() {
        let app = XCUIApplication()
        app.launch()
        
        let screen = DrawsScreen(app: app)
        
        screen.assertScreenVisible()
            .tapFirstDraw()
            .assertScreenVisible()
            .assertTicketDoesNotExist()
            .tapGenerateTickets()
            .assertTicketExist()
    }
}
