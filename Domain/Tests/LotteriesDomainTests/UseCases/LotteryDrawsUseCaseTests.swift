import XCTest
import JSONService
@testable import LotteriesDomain

final class LotteryDrawsUseCaseTests: XCTestCase {
    
    private let fakeURL = URL(string: "fake.url")!
    
    private var useCase: LotteryDrawsUseCase!
    private var mockJSONService: MockJSONService!
    
    override func setUp() {
        super.setUp()
        mockJSONService = MockJSONService()
        useCase = LotteryDrawsUseCase(jsonService: mockJSONService, url: fakeURL)
    }
    
    override func tearDown() {
        mockJSONService = nil
        useCase = nil
        super.tearDown()
    }
    
    func testGivenURL_WhenCallFetch_ThenResultIsSuccess() {
        mockJSONService.stubResult = {
            LotteriesResponse.fixture()
        }
        
        do {
            let result = try useCase.fetch()
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
        
        XCTAssertEqual(mockJSONService.capturedURL?.absoluteString, "fake.url")
    }
    
    func testGivenNoULR_WhenCallFetch_ThenResultIsFailureWithResourceCouldNotBeFoundError() {
        useCase = LotteryDrawsUseCase(jsonService: mockJSONService, url: nil)
        
        do {
            _ = try useCase.fetch()
            return XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .resourceCouldNotBeFound = capturedError else {
                return XCTFail("Error should be resourceCouldNotBeFound")
            }
        }
        
        XCTAssertNil(mockJSONService.capturedURL?.absoluteString)
    }
    
    func testGivenUnableToReadFromURLError_WhenCallFetch_ThenResultIsFailureWithDomainUnableToReadFromURLError() {
        mockJSONService.stubResult = {
            throw JSONError.unableToReadFromURL
        }
        
        do {
            _ = try useCase.fetch()
            return XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .unableToReadFromURL = capturedError else {
                return XCTFail("Error should be unableToReadFromURL")
            }
        }
        
        XCTAssertEqual(mockJSONService.capturedURL?.absoluteString, "fake.url")
    }
    
    func testGivenUnableToDecodeError_WhenCallFetch_ThenResultIsFailureWithOtherError() {
        mockJSONService.stubResult = {
            throw JSONError.unableToDecode
        }
        
        do {
            _ = try useCase.fetch()
            return XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .other = capturedError else {
                return XCTFail("Error should be other")
            }
        }
        
        XCTAssertEqual(mockJSONService.capturedURL?.absoluteString, "fake.url")
    }
    
    func testGivenRundomError_WhenCallFetch_ThenResultIsFailureWithOtherError() {
        mockJSONService.stubResult = {
            throw NSError(domain: NSCocoaErrorDomain, code: CocoaError.fileReadNoSuchFile.rawValue, userInfo: [
                NSLocalizedDescriptionKey: "The file could not be opened because it does not exist."
            ])
        }
        
        do {
            _ = try useCase.fetch()
            return XCTFail("Should throw an erron")
        } catch {
            guard let capturedError = error as? DomainError else {
                return XCTFail("Error should be DomainError")
            }
            
            guard case .other = capturedError else {
                return XCTFail("Error should be other")
            }
        }
        
        XCTAssertEqual(mockJSONService.capturedURL?.absoluteString, "fake.url")
    }
}
