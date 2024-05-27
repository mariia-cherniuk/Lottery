import Foundation

public final class CurrencyFormatter {
    
    private let numberFormatter: NumberFormatter
    
    public init(formatter: NumberFormatter) {
        self.numberFormatter = formatter
    }
    
    public func string(from minorUnits: Int, currencyCode: String) -> String? {
        let decimal = NSDecimalNumber.decimal(from: minorUnits)
        numberFormatter.currencyCode = currencyCode
        return numberFormatter.string(from: decimal as NSNumber)
    }
}
