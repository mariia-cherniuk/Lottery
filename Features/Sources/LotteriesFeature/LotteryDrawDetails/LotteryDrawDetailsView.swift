import SwiftUI
import DesignLibrary

public struct LotteryDrawDetailsView: View {
    
    private let viewModel: LotteryDrawDetailsViewModel
    
    public init(viewModel: LotteryDrawDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            content
        }
        .padding(.horizontal)
        .navigationTitle("Lottery Draw Details")
    }
}

private extension LotteryDrawDetailsView {
    
    var content: some View {
        VStack(spacing: .spacing.large) {
            lotteryBalls
            header
            button
        }
    }
    
    var header: some View {
        Text("Good luck with your lottery ticket 🤞")
    }
    
    var lotteryBalls: some View {
        VStack(alignment: .leading, spacing: .spacing.large) {
            title(message: "Results")
            lotteryBallsView
        }
    }
    
    var lotteryBallsView: some View {
        LotteryBallsView(viewModels: viewModel.ballViewModels)
    }
    
    func title(message: String) -> some View {
        Text(message)
            .font(.title2)
            .bold()
    }
    
    var button: some View {
        Button("Generate ticket") {
            //TODO: Implement tap
        }
    }
}
