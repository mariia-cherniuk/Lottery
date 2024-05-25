import SwiftUI
import DesignLibrary

struct LotteryBallsView: View {
    
    private let viewModels: [BallViewModel]
    
    init(viewModels: [BallViewModel]) {
        self.viewModels = viewModels
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        content
            .accessibilityElement(children: .combine)
    }
}

private extension LotteryBallsView {
    
    var content: some View {
        LazyVGrid(columns: columns, spacing: .spacing.large) {
            
            ///ForEach requires each element to have a unique identifier to distinguish between different items.
            ///When you use id: \.self, SwiftUI uses the element itself as the identifier.
            ///To ensure each item has a unique identifier, I decided to wrap items in a structure that includes a unique identifier.
            
            ForEach(Array(viewModels.enumerated()), id: \.offset) { index, viewModel in
                BallView(viewModel: viewModel)
            }
        }
        .padding(.large)
    }
}
