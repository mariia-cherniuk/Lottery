import SwiftUI

public struct BallViewModel {
    
    let number: String
    let colour: Color
    
    public init(number: String, colour: Color) {
        self.number = number
        self.colour = colour
    }
}
