import SwiftUI
import DesignLibrary

struct LotteryDrawView: View {
    
    private let viewModel: LotteryDraw
    
    init(viewModel: LotteryDraw) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.large)
            .overlay(OverlayView())
    }
}

private extension LotteryDrawView {
    
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
