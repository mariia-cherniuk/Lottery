import XCTest
import NetworkManagement
import Formatters

@testable import LotteriesDomain

final class LotteryDrawsUseCaseTests: XCTestCase {
    
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.drawDateFormatter)
        return encoder
    }()
    
    private var useCase: LotteryDrawsUseCase!
    private var mockDataLoader: MockDataLoader!
    private var mockLotteriesStorage: MockLotteriesStorage!
    
    override func setUp() {
        super.setUp()
        mockDataLoader = MockDataLoader()
        mockLotteriesStorage = MockLotteriesStorage()
        useCase = LotteryDrawsUseCase(dataLoader: mockDataLoader, lotteriesStorage: mockLotteriesStorage)
    }
    
    override func tearDown() {
        mockLotteriesStorage = nil
        mockDataLoader = nil
        useCase = nil
        super.tearDown()
    }
    
    // MARK: - Test success
    func testGivenData_WhenCallFetch_ThenResultIsSuccess() async {
        let lotteries = [Lottery.fixture()]
        let lotteriesResponse = LotteriesResponse(draws: lotteries)
        mockDataLoader.stubResponse = {
            try! self.jsonEncoder.encode(lotteriesResponse)
        }

        do {
            let result = try await useCase.fetch()
            XCTAssertEqual(result.count, 1)
            XCTAssertEqual(result.first?.id, "id")
            XCTAssertEqual(result.first?.number1, 2)
            XCTAssertEqual(result.first?.number2, 16)
            XCTAssertEqual(result.first?.number3, 23)
            XCTAssertEqual(result.first?.number4, 44)
            XCTAssertEqual(result.first?.number5, 47)
            XCTAssertEqual(result.first?.number6, 52)
            XCTAssertEqual(result.first?.drawDate, Date.fixture())
            XCTAssertEqual(result.first?.bonusBall, 14)
            XCTAssertEqual(result.first?.topPrize, 4000000000)
        } catch {
            return XCTFail("Result should be success")
        }
        
        XCTAssertEqual(mockDataLoader.capturedResource?.path, "/mariia-cherniuk/Lottery/master/Resources/lotteries.json")
        XCTAssertEqual(mockDataLoader.capturedResource?.method.rawValue, "GET")
    }
    
    // MARK: - Test failure
    func testGivenNotConnectedToInternetError_WhenFetchIsCalled_ThenCallLotteriesStore() async {
        mockDataLoader.stubResponse = {
            throw NetworkError.notConnectedToInternet
        }
        
        do {
            let _ = try await useCase.fetch()
        } catch {
            return XCTFail("Result should be success")
        }
        
        XCTAssertTrue(mockLotteriesStorage.fetchWasCalled)
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
