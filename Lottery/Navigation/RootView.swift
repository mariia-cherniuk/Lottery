import SwiftUI
import LotteriesFeature

struct RootView: View {
    
    private let viewModel: LotteryListViewModel
    
    @ObservedObject private var coordinator: Coordinator
    
    init(viewModel: LotteryListViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.destinations) {
            LotteryListView(viewModel: viewModel)
                .navigationDestination(for: Coordinator.Destination.self) { destination in
                    switch destination {
                    case .detail:
                        Text("details")
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
