import SwiftUI

public struct ActivityIndicator: View {
    
    public init() {}
    
    public var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .purple))
            .scaleEffect(1)
            .padding(.large)
    }
}
