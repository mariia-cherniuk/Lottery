import Foundation

extension NSDecimalNumber {
    
    static func decimal(from minorUnits: Int) -> NSDecimalNumber {
        NSDecimalNumber(decimal: Decimal(minorUnits))
            .dividing(by: NSDecimalNumber(value: 100))
    }
}
