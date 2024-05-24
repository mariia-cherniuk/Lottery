import SwiftUI

public struct LotteryListView: View {
    
    private let viewModel: LotteryListViewModel
    
    public init(viewModel: LotteryListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("LotteryListView")
            .onAppear(perform: viewModel.onAppear)
    }
}

