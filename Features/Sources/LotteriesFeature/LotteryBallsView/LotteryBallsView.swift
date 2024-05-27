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
            
            ///ForEach requires each element to have a unique identifier to distinguish between different items.
            ///When you use id: \.self, SwiftUI uses the element itself as the identifier.
            ///To ensure each item has a unique identifier, I decided to wrap items in a structure that includes a unique identifier.
            
            ForEach(Array(viewModels.enumerated()), id: \.offset) { index, viewModel in
                BallView(viewModel: viewModel)
                 //   .frame(width: 50, height: 50)
            }
        }
        .padding(.large)
    }
}
