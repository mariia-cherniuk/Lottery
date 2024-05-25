import SwiftUI

public struct LotteryDrawDetailsView: View {
    
    private let viewModel: LotteryDraw
    
    public init(viewModel: LotteryDraw) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        HStack(spacing: .spacing.large) {
            Text(viewModel.date)
            Spacer()
            Text("Details")
        }
        .contentShape(Rectangle())
    }
}
