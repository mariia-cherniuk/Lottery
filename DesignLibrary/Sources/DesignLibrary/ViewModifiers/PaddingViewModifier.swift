import Foundation
import SwiftUI

struct PaddingViewModifier: ViewModifier {
    
    private let length: CGFloat
    
    init(length: CGFloat) {
        self.length = length
    }
    
    func body(content: Content) -> some View {
        content
            .padding(length)
    }
}
