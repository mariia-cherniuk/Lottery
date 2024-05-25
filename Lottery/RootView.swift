import SwiftUI
import LotteriesFeature

struct RootView: View {
    
    private let viewModel: LotteryDrawsViewModel
    
    @ObservedObject private var coordinator: Coordinator
    
    init(viewModel: LotteryDrawsViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.destinations) {
            LotteryDrawsView(viewModel: viewModel)
                .navigationDestination(for: Coordinator.Destination.self) { destination in
                    switch destination {
                    case .detail(let lottery):
                        LotteryDrawDetailsView(viewModel: coordinator.makeLotteryDrawDetailsViewModel(lottery))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
