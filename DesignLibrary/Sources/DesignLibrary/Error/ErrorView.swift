import SwiftUI

public struct ErrorView: View {
    
    private let viewModel: ErrorViewModel
    
    public init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 16.0) {
            Group {
                Text(viewModel.title)
                    .font(.headline)
                    .foregroundColor(.red)
                
                Text(viewModel.message)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .font(.body)
            }
            .accessibilityElement(children: .combine)
            
            button
        }
        .padding(16.0)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
    
    private var button: some View {
        Button(viewModel.actionTitle) {
            Task {
                await viewModel.action()
            }
        }
        .padding(16.0)
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
