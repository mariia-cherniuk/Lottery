import JSONService

public final class UseCaseFactory {
    
    private let fileManager: FileDataManaging
    
    public init(fileManager: FileDataManaging) {
        self.fileManager = fileManager
    }
    
    public func makeLotteryListUseCase() -> LotteryListUseCaseProtocol {
        LotteryListUseCase(jsonService: JSONService(fileManager: fileManager))
    }
}
