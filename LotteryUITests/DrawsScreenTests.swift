import XCTest

final class DrawsScreenTests: XCTestCase {
    
    func testCanNavigateToDrawDetails() {
        let app = XCUIApplication()
        app.launch()
        
        let screen = DrawsScreen(app: app)
        
        screen.assertScreenVisible()
            .tapFirstDraw()
            .assertTabbedScreenVisible()
    }
}
