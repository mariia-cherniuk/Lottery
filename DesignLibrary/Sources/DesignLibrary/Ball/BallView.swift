import SwiftUI

public struct BallView: View {
    
    private let viewModel: BallViewModel
    
    public init(viewModel: BallViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text(viewModel.number)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(viewModel.colour)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4)
            )
            .shadow(radius: 10)
            .accessibilityElement(children: .combine)
    }
}
