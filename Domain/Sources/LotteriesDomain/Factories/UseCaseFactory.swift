import Foundation
import NetworkManagement

public final class UseCaseFactory {
    
    private let dataLoader: DataLoading
    
    public init(environment: NetworkManagement.Environment) {
        self.dataLoader = DataLoader(session: URLSession.shared, environment: environment)
    }
    
    public func makeLotteryDrawsUseCase() -> LotteryDrawsUseCaseProtocol {
        LotteryDrawsUseCase(dataLoader: dataLoader)
    }
}
