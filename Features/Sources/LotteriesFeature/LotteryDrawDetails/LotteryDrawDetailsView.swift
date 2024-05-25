import SwiftUI

public struct LotteryDrawDetailsView: View {
    
    private let viewModel: LotteryDrawDetailsViewModel
    
    public init(viewModel: LotteryDrawDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .padding(.large)
            .navigationTitle("Lottery Draw Details")
    }
}

private extension LotteryDrawDetailsView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: .spacing.small) {
            title
            Spacer()
            lotteryBallsView
        }
        .contentShape(Rectangle())
    }
    
    var title: some View {
        Text("Your numbers")
            .font(.title2)
            .bold()
    }
    
    var lotteryBallsView: some View {
        LotteryBallsView(ballNumbers: viewModel.numbers)
    }
}
