import XCTest
import Combine
import LotteriesDomain

@testable import LotteriesFeature

@MainActor
final class LotteryDrawsViewModelTests: XCTestCase {
   
    private lazy var lotteries = [Lottery.fixture()]
    
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
    
    // MARK: - Test onTap
    func testWhenOnTapIsCalled_ThenCallCoordinator() {
        viewModel.onTap(.fixture(id: "lottery-id"))
        XCTAssertEqual(mockCoordinator.capturedLottery?.id, "lottery-id")
    }
    
    // MARK: - Test onTabbedTap
    func testWhenOnTabbedTapIsCalled_ThenCallCoordinator() {
        performSuccess(description: #function)
        viewModel.onTabbedTap()
        
        XCTAssertEqual(mockCoordinator.capturedLotteries?.count, 1)
        XCTAssertEqual(mockCoordinator.capturedLotteries?.first?.id, "id")
    }
    
    // MARK: - Test success
    func testWhenOnAppearIsCalled_ThenCallFetch() {
        performSuccess(description: #function)
        
        XCTAssertTrue(mockUseCase.fetchWasCalled)
    }
    
    func performSuccess(description: String) {
        mockUseCase.stubResponse = {
            self.lotteries
        }
        
        let expectation = self.expectation(description: description)
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
    }
    
    func testStatesForSuccessResponse() {
        mockUseCase.stubResponse = {
            self.lotteries
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
    
    func testGivenLotteries_WhenOnAppearIsCalled_ThenStateIsLoaded() {
        mockUseCase.stubResponse = {
            self.lotteries
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
        XCTAssertEqual(response.first?.id, lotteries.first?.id)
        XCTAssertEqual(response.first?.date, "15 May 2023")
    }
    
    // MARK: - Test failure
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
    
    func testNoLotteries_WhenOnAppearIsCalled_ThenStateIsError() {
        mockUseCase.stubResponse = {
            []
        }
        
        performOnAppearAndAwaitForExpectations(function: #function)
        
        guard case .error(let errorModel) = viewModel.state else {
            return XCTFail("State should be error")
        }
        
        XCTAssertEqual(errorModel.title, "Oh no 😢")
        XCTAssertEqual(errorModel.message, "The content you requested is currently empty.")
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
