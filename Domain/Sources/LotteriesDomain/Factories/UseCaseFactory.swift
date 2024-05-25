import Foundation
import NetworkManagement
import Storage

public final class UseCaseFactory {
    
    private let store = LotteriesStore(storage: KeyValueStorage(defaults: UserDefaults.standard))
    
    private let dataLoader: DataLoading
    
    public init(environment: NetworkManagement.Environment) {
        self.dataLoader = DataLoader(session: URLSession.shared, environment: environment)
    }
    
    public func makeLotteryDrawsUseCase() -> LotteryDrawsUseCaseProtocol {
        LotteryDrawsUseCase(dataLoader: dataLoader, lotteriesStorage: store)
    }
}
