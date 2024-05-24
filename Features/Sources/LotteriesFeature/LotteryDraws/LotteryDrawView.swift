import SwiftUI

struct LotteryDrawView: View {
    
    private let viewModel: LotteryDraw
    
    init(viewModel: LotteryDraw) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(viewModel.date)
    }
}
