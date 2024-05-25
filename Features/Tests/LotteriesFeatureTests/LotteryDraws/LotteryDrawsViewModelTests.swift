import XCTest
import Combine
import LotteriesDomain

@testable import LotteriesFeature

@MainActor
final class LotteryDrawsViewModelTests: XCTestCase {
   
    private lazy var lotteriesResponse = LotteriesResponse(draws: [.fixture()])
    
    private var mockCoordinator: MockLotteriesCoordinator!
    private var mockUseCase: MockLotteryDrawsUseCase!
    private var viewModel: LotteryDrawsViewModel!
    
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockLotteriesCoordinator()
        mockUseCase = MockLotteryDrawsUseCase()
        viewModel = LotteryDrawsViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
    }
    
    override func tearDown() {
        cancellables = []
        mockCoordinator = nil
        mockUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialStateIsIdle() {
        guard case .idle = viewModel.state else {
            return XCTFail("State should be idle")
        }
    }
    
    // MARK: - Test success
    func testWhenOnAppearIsCalled_ThenCallFetch() {
        mockUseCase.stubResponse = {
            self.lotteriesResponse
        }
        
        let expectation = self.expectation(description: #function)
        viewModel.onAppear()
        
        viewModel.$state.sink { state in
            switch state {
            case .loaded:
                expectation.fulfill()
            default:
                break
            }
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(mockUseCase.fetchWasCalled)
    }
    
    func testStatesForSuccessResponse() {
        mockUseCase.stubResponse = {
            self.lotteriesResponse
        }
        
        var capturedStates: [LotteryDrawsViewModel.State] = []
        
        viewModel.$state.sink { state in
            capturedStates.append(state)
        }
        .store(in: &cancellables)
        
        let expectation = self.expectation(description: #function)
        viewModel.onAppear()
        
        viewModel.$state.onReceiveLoaded {
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
        
        XCTAssertEqual(capturedStates.count, 3)
        
        guard case .idle = capturedStates.first else {
            return XCTFail("State should be idle")
        }
        
        guard case .loading = capturedStates[1] else {
            return XCTFail("State should be loading")
        }
        
        guard case .loaded(let lotteryDraws) = capturedStates.last else {
            return XCTFail("State should be loaded")
        }
        
        XCTAssertEqual(lotteryDraws.first?.date, "15 May 2023")
    }
    
    func testGivenLotteriesResponse_WhenOnAppearIsCalled_ThenStateIsLoaded() {
        mockUseCase.stubResponse = {
            self.lotteriesResponse
        }
        
        let expectation = self.expectation(description: #function)
        viewModel.onAppear()
        
        viewModel.$state.onReceiveLoaded {
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
        
        guard case .loaded(let response) = viewModel.state else {
            return XCTFail("State should be loaded")
        }
        
        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response.first?.id, lotteriesResponse.draws.first?.id)
        XCTAssertEqual(response.first?.date, "15 May 2023")
    }
    
    // MARK: - Test failure
    func testGivenNotConnectedToInternetError_WhenOnAppearIsCalled_ThenStateIsErrorWithCorrectMessage() {
        mockUseCase.stubResponse = {
            throw DomainError.notConnectedToInternet
        }
        
        performOnAppearAndAwaitForExpectations(function: #function)
        
        guard case .error(let errorModel) = viewModel.state else {
            return XCTFail("State should be error")
        }
        
        XCTAssertEqual(errorModel.title, "Oh no 😢")
        XCTAssertEqual(errorModel.message, "No Internet connection. Please check your connection and try again.")
    }
    
    func testGivenRundomError_WhenOnAppearIsCalled_ThenStateIsErrorWithCorrectMessage() {
        mockUseCase.stubResponse = {
            throw MockError()
        }
        
        performOnAppearAndAwaitForExpectations(function: #function)
        
        guard case .error(let errorModel) = viewModel.state else {
            return XCTFail("State should be error")
        }
        
        XCTAssertEqual(errorModel.title, "Oh no 😢")
        XCTAssertEqual(errorModel.message, "Smth went wrong, please try again.")
    }
    
    private func performOnAppearAndAwaitForExpectations(function: String) {
        let expectation = self.expectation(description: function)
        viewModel.onAppear()
        
        viewModel.$state.onReceiveError {
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1)
    }
}

private extension Publisher where Output == LotteryDrawsViewModel.State, Failure == Never {
   
    func onReceiveLoaded(_ f: @escaping () -> Void) -> Cancellable {
        self.sink { state in
            switch state {
            case .loaded:
                f()
            default:
                break
            }
        }
    }
    
    func onReceiveError(_ f: @escaping () -> Void) -> Cancellable {
        self.sink { state in
            switch state {
            case .error:
                f()
            default:
                break
            }
        }
    }
}
