import SwiftUI
import DesignLibrary

struct LotteryDrawView: View {
    
    private let viewModel: LotteryDraw
    
    init(viewModel: LotteryDraw) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TitleDetailsView(title: "Draw date:", details: viewModel.date)
            .contentShape(Rectangle())
            .padding(.large)
            .overlay(overlay)
    }
}

private extension LotteryDrawView {
    
    var overlay: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.purple, lineWidth: 1)
    }
}
