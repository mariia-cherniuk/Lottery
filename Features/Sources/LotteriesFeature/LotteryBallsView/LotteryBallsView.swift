import SwiftUI
import DesignLibrary

struct LotteryBallsView: View {
    
    private let ballNumbers: [String]
    
    init(ballNumbers: [String]) {
        self.ballNumbers = ballNumbers
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
        ScrollView {
            LazyVGrid(columns: columns, spacing: .spacing.large) {
        
                ///ForEach requires each element to have a unique identifier to distinguish between different items.
                ///When you use id: \.self, SwiftUI uses the element itself as the identifier.
                ///To ensure each item has a unique identifier, I decided to wrap items in a structure that includes a unique identifier.
                
                ForEach(Array(ballNumbers.enumerated()), id: \.offset) { index, number in
                    BallView(number: number)
                }
            }
            .padding(.large)
        }
    }
}
