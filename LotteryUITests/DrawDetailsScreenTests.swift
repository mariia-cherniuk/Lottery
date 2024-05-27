import XCTest

final class DrawDetailsScreenTests: XCTestCase {

    func testCanGenerateTickets() {
        let app = XCUIApplication()
        app.launch()
        
        let screen = DrawsSceen(app: app)
        
        screen.assertScreenVisible()
            .tapFirstDraw()
            .assertScreenVisible()
            .tapGenerateTicketsButton()
    }
}
