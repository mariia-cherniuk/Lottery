import SwiftUI

public struct BallViewModel {
    
    public let number: Int
    public let colour: Color
    
    public init(number: Int, colour: Color) {
        self.number = number
        self.colour = colour
    }
}
