import SwiftUI

public struct TabDetailsView: View {
    
    private let viewModels: [LotteryDrawDetailsViewModel]
    
    public init(viewModels: [LotteryDrawDetailsViewModel]) {
        self.viewModels = viewModels
    }
    
    public var body: some View {
        TabView {
            ForEach(Array(viewModels.enumerated()), id: \.offset) { _, viewModel in
                LotteryDrawDetailsView(viewModel: viewModel)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}
