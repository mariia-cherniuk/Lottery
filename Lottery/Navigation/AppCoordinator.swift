import SwiftUI
import JSONService
import LotteriesDomain
import LotteriesFeature

final class AppCoordinator {
    
    private let useCaseFactory = UseCaseFactory(fileManager: FileDataManager())
    
    @MainActor
    func makeRootView() -> some View {
        let coordinator = Coordinator(useCaseFactory: useCaseFactory)
        let useCase = useCaseFactory.makeLotteryDrawsUseCase()
        let viewModel = LotteryDrawsViewModel(useCase: useCase, coordinator: coordinator)
        return RootView(viewModel: viewModel, coordinator: coordinator)
    }
}
