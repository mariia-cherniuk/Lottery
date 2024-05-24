import SwiftUI

public struct LotteryListView: View {
    
    @ObservedObject private var viewModel: LotteryListViewModel
    
    public init(viewModel: LotteryListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("LotteryListView")
            .onAppear(perform: viewModel.onAppear)
    }
}

