import SwiftUI
import DesignLibrary

struct LotteryBallsView: View {
    
    private let viewModels: [BallViewModel]
    
    init(viewModels: [BallViewModel]) {
        self.viewModels = viewModels
    }
    
    var body: some View {
        content
            .accessibilityElement(children: .combine)
    }
}

private extension LotteryBallsView {
    
    var content: some View {
        HStack {
            ForEach(viewModels, id: \.number) { viewModel in
                BallView(viewModel: viewModel)
            }
        }
        .padding(.large)
    }
}
