import SwiftUI

public struct LotteryDrawDetailsView: View {
    
    private let viewModel: LotteryDrawDetailsViewModel
    
    public init(viewModel: LotteryDrawDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        HStack(spacing: .spacing.large) {
            Text("Details")
            Spacer()
            Text("Details")
        }
        .contentShape(Rectangle())
    }
}
