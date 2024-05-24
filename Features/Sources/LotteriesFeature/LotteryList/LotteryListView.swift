import SwiftUI
import DesignLibrary

public struct LotteryListView: View {
    
    @ObservedObject private var viewModel: LotteryListViewModel
    
    public init(viewModel: LotteryListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
    }
}

private extension LotteryListView {
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
            
        case .loading:
            ActivityIndicator()
                .frame(width: 50.0)
            
        case .loaded:
            Text("Loaded")
            
        case .error(let model):
            ErrorView(viewModel: model)
        }
    }
    
    var loaded: some View {
        VStack {
            Text("yest")
        }
    }
}
