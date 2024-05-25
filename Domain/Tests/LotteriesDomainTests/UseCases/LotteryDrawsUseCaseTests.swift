import XCTest
import NetworkManagement
@testable import LotteriesDomain

final class LotteryDrawsUseCaseTests: XCTestCase {
    
    private var useCase: LotteryDrawsUseCase!
    private var mockDataLoader: MockDataLoader!
    
    override func setUp() {
        super.setUp()
        mockDataLoader = MockDataLoader()
        useCase = LotteryDrawsUseCase(dataLoader: mockDataLoader)
    }
    
    override func tearDown() {
        mockDataLoader = nil
        useCase = nil
        super.tearDown()
    }
    
    // MARK: - Test success
    func testGivenData_WhenCallFetch_ThenResultIsSuccess() async {
        let lotteriesResponse = LotteriesResponse.fixture()
        mockDataLoader.stubResponse = {
            try! JSONEncoder().encode(lotteriesResponse)
        }

        do {
            let result = try await useCase.fetch()
            XCTAssertEqual(result.draws.count, 1)
            XCTAssertEqual(result.draws.first?.id, "id")
            XCTAssertEqual(result.draws.first?.number1, "2")
            XCTAssertEqual(result.draws.first?.number2, "16")
            XCTAssertEqual(result.draws.first?.number3, "23")
            XCTAssertEqual(result.draws.first?.number4, "44")
            XCTAssertEqual(result.draws.first?.number5, "47")
            XCTAssertEqual(result.draws.first?.number6, "52")
            XCTAssertEqual(result.draws.first?.drawDate, "2023-05-15")
            XCTAssertEqual(result.draws.first?.bonusBall, "14")
            XCTAssertEqual(result.draws.first?.topPrize, 4000000000)
        } catch {
            return XCTFail("Result should be success")
        }
        
        XCTAssertEqual(mockDataLoader.capturedResource?.path, "/mariia-cherniuk/Lottery/master/Resources/lotteries.json")
        XCTAssertEqual(mockDataLoader.capturedResource?.method.rawValue, "GET")
    }
    
    // MARK: - Test failure
    func testGivenNotConnectedToInternetError_WhenFetchIsCalled_ThenResponseIsFailureWithDomainNotConnectedToInternetError() async {
        mockDataLoader.stubResponse = {
            throw NetworkError.notConnectedToInternet
        }
        
        do {
            let _ = try await useCase.fetch()
            return XCTFail("Fetch should fail")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .notConnectedToInternet = capturedError else {
                return XCTFail("Error should be notConnectedToInternet")
            }
        }
        
        XCTAssertEqual(mockDataLoader.capturedResource?.path, "/mariia-cherniuk/Lottery/master/Resources/lotteries.json")
        XCTAssertEqual(mockDataLoader.capturedResource?.method.rawValue, "GET")
    }
    
    func testGivenInvalidResponseError_WhenFetchIsCalled_ThenResponseIsFailureWithOtherError() async {
        mockDataLoader.stubResponse = {
            throw NetworkError.invalidResponse
        }
        
        do {
            let _ = try await useCase.fetch()
            return XCTFail("Fetch should fail")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .other = capturedError else {
                return XCTFail("Error should be other")
            }
        }
        
        XCTAssertEqual(mockDataLoader.capturedResource?.path, "/mariia-cherniuk/Lottery/master/Resources/lotteries.json")
        XCTAssertEqual(mockDataLoader.capturedResource?.method.rawValue, "GET")
    }
    
    func testGivenNetworkErrorError_WhenFetchIsCalled_ThenResponseIsFailureWithOtherError() async {
        mockDataLoader.stubResponse = {
            throw NetworkError.networkError(MockError())
        }
       
        do {
            let _ = try await useCase.fetch()
            return XCTFail("Fetch should fail")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .other = capturedError else {
                return XCTFail("Error should be other")
            }
        }
        
        XCTAssertEqual(mockDataLoader.capturedResource?.path, "/mariia-cherniuk/Lottery/master/Resources/lotteries.json")
        XCTAssertEqual(mockDataLoader.capturedResource?.method.rawValue, "GET")
    }
    
    func testGivenRundomError_WhenFetchIsCalled_ThenResponseIsFailureWithOtherError() async {
        mockDataLoader.stubResponse = {
            throw MockError()
        }
        
        do {
            let _ = try await useCase.fetch()
            return XCTFail("Fetch should fail")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .other = capturedError else {
                return XCTFail("Error should be other")
            }
        }
        
        XCTAssertEqual(mockDataLoader.capturedResource?.path, "/mariia-cherniuk/Lottery/master/Resources/lotteries.json")
        XCTAssertEqual(mockDataLoader.capturedResource?.method.rawValue, "GET")
    }
}
