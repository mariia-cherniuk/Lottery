import SwiftUI

public extension View {
    
    func padding(_ length: LotteryPadding) -> some View {
        modifier(PaddingViewModifier(length: length.rawValue))
    }
    
    func onAppearOnce(_ action: @escaping () -> Void) -> some View {
        modifier(OnAppearOnce(action: action))
    }
}
