import SwiftUI
import DesignLibrary

public struct LotteryDrawsView: View {
    
    @ObservedObject private var viewModel: LotteryDrawsViewModel
    
    public init(viewModel: LotteryDrawsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .onAppearOnce {
                viewModel.onAppear()
            }
            .navigationTitle("Lottery Draws")
            .accessibilityIdentifier(AccessibilityIdentifiers.DrawsScreen.name)
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
    
    func loaded(lotteryDraws: [LotteryDrawCellViewModel]) -> some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: .spacing.large) {
                ForEach(Array(lotteryDraws.enumerated()), id: \.element.id) { index, lotteryDraw in
                    LotteryDrawCellView(viewModel: lotteryDraw)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityIdentifier(AccessibilityIdentifiers.DrawsScreen.draw(at: index))
                        .onTapGesture {
                            viewModel.onTabbedTap()
                          //  viewModel.onTap(lotteryDraw.lottery)
                        }
                }
            }
            .padding(.large)
        }
    }
}
