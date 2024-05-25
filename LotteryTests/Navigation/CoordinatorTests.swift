import XCTest
import LotteriesDomain
import NetworkManagement
@testable import Lottery

final class CoordinatorTests: XCTestCase {
    
    private let useCaseFactory = UseCaseFactory(environment: NetworkManagement.Environment(schema: "https", host: "lottery.uat.test"))
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
        let lottery1 = Lottery.fixture(id: "id-1")
        let lottery2 = Lottery.fixture(id: "id-2")
        
        XCTAssertEqual(coordinator.destinations, [])
        coordinator.showDetails(lottery1)
        
        XCTAssertEqual(coordinator.destinations, [.detail(lottery1)])
        coordinator.showDetails(lottery2)
        
        XCTAssertEqual(coordinator.destinations, [.detail(lottery1), .detail(lottery2)])
    }
}
