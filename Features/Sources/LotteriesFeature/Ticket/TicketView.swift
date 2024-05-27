import SwiftUI
import DesignLibrary

struct TicketView: View {
    
    private let viewModel: TicketViewModel
    
    public init(viewModel: TicketViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .spacing.large) {
            header
            lotteryBallsView
        }
        .padding(.large)
        .overlay(OverlayView())
    }
}

private extension TicketView {
    
    var header: some View {
        Text(viewModel.message)
    }
    
    var lotteryBallsView: some View {
        LotteryBallsView(viewModels: viewModel.ballViewModels)
    }
}
