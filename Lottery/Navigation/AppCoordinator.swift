import SwiftUI
import JSONService
import LotteriesDomain
import LotteriesFeature

final class AppCoordinator {
    
    private let useCaseFactory = UseCaseFactory(fileManager: FileDataManager())
    
    func makeRootView() -> some View {
        let coordinator = Coordinator(useCaseFactory: useCaseFactory)
        let useCase = useCaseFactory.makeLotteryListUseCase()
        let viewModel = LotteryListViewModel(useCase: useCase)
        return RootView(viewModel: viewModel, coordinator: coordinator)
    }
}
