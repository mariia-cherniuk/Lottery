import SwiftUI

public struct BallViewModel {
    
    public let number: String
    public let colour: Color
    
    public init(number: String, colour: Color) {
        self.number = number
        self.colour = colour
    }
}
