import XCTest

final class DrawsScreenTests: XCTestCase {
    
    func testCanNavigateToDrawDetails() {
        let app = XCUIApplication()
        app.launch()
        
        let screen = DrawsSceen(app: app)
        
        screen.assertScreenVisible()
            .tapFirstDraw()
            .assertScreenVisible()
    }
}
