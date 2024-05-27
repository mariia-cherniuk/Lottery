import SwiftUI
import DesignLibrary

public struct TabDrawDetailsView: View {
    
    private let viewModels: [LotteryDrawDetailsViewModel]
    
    public init(viewModels: [LotteryDrawDetailsViewModel]) {
        self.viewModels = viewModels
    }
    
    public var body: some View {
        TabView {
            ForEach(Array(viewModels.enumerated()), id: \.offset) { index, viewModel in
                LotteryDrawDetailsView(viewModel: viewModel)
                    .accessibilityIdentifier(AccessibilityIdentifiers.DrawDetailsScreen.tab(at: index + 1))
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .accessibilityIdentifier(AccessibilityIdentifiers.DrawDetailsScreen.tabbedScreenName)
    }
}
