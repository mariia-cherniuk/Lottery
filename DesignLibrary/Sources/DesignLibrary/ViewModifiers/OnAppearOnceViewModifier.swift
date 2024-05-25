import SwiftUI

public struct OnAppearOnce: ViewModifier {
    
    @State private var hasAppeared = false
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                action()

            }
    }
}
