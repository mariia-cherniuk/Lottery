import SwiftUI

public extension View {
    
    func padding(_ length: LotteryPadding) -> some View {
        modifier(PaddingViewModifier(length: length.rawValue))
    }
}
