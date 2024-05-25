import SwiftUI
import DesignLibrary

public struct LotteryDrawsView: View {
    
    @ObservedObject private var viewModel: LotteryDrawsViewModel
    
    public init(viewModel: LotteryDrawsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .onAppear(perform: viewModel.onAppear)
    }
}

private extension LotteryDrawsView {
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
            
        case .loading:
            ActivityIndicator()
                .frame(width: 50.0)
            
        case .loaded(let lotteryDraws):
            loaded(lotteryDraws: lotteryDraws)
            
        case .error(let model):
            ErrorView(viewModel: model)
        }
    }
    
    func loaded(lotteryDraws: [LotteryDraw]) -> some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: .spacing.large) {
                ForEach(lotteryDraws, id: \.id) { lotteryDraw in
                    LotteryDrawView(viewModel: lotteryDraw)
                        .onTapGesture {
                            viewModel.onTap(lotteryDraw)
                        }
                }
            }
            .padding(.large)
        }
    }
}
