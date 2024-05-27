import Foundation

struct SequentialNumberGenerator: RandomNumberGenerator {
    private var currentValue: UInt64
    
    init() {
        self.currentValue = 0
    }
    
    mutating func next() -> UInt64 {
        currentValue += 1
        return currentValue
    }
}
