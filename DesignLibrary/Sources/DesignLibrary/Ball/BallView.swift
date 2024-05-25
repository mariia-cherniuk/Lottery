import SwiftUI

public struct BallView: View {
    
    private let viewModel: BallViewModel
    
    public init(viewModel: BallViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text(viewModel.number)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(viewModel.colour)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4)
            )
            .shadow(radius: 4)
            .accessibilityElement(children: .combine)
    }
}
