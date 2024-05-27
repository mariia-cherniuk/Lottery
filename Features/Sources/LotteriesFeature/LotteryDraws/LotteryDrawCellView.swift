import SwiftUI
import DesignLibrary

struct LotteryDrawCellView: View {
    
    private let viewModel: LotteryDrawCellViewModel
    
    init(viewModel: LotteryDrawCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.large)
            .overlay(OverlayView())
    }
}

private extension LotteryDrawCellView {
    
    var content: some View {
        VStack(spacing: .spacing.large) {
            dateView
            if let topPrize = viewModel.topPrize {
                topPrizeView(details: topPrize)
            }
        }
    }
    
    var dateView: some View {
        TitleDetailsView(title: "Draw date:", details: viewModel.date)
    }
    
    func topPrizeView(details: String) -> some View {
        TitleDetailsView(title: "Top prize:", details: details)
    }
}
