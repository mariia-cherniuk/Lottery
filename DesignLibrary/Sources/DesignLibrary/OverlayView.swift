import SwiftUI

public struct OverlayView: View {
    
    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.purple, lineWidth: 1)
    }
}
