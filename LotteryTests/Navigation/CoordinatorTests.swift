import XCTest
import LotteriesDomain
@testable import Lottery

final class CoordinatorTests: XCTestCase {
    
    private let useCaseFactory = UseCaseFactory(fileManager: MockFileDataManager())
    private var coordinator: Coordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = Coordinator(useCaseFactory: useCaseFactory)
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    func testShowDetails() {
        XCTAssertEqual(coordinator.destinations, [])
        coordinator.showDetails()
        XCTAssertEqual(coordinator.destinations, [.detail])
        coordinator.showDetails()
        XCTAssertEqual(coordinator.destinations, [.detail, .detail])
    }
}
