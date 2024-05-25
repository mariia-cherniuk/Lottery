import SwiftUI

public struct BallView: View {
    
    private let number: String
    
    public init(number: String) {
        self.number = number
    }
    
    public var body: some View {
        Text(number)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(Color.red)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4)
            )
            .shadow(radius: 10)
            .accessibilityElement(children: .combine)
    }
}
