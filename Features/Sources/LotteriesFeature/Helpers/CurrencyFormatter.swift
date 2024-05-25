import Foundation

final class CurrencyFormatter {
    
    private let numberFormatter: NumberFormatter
    
    init(formatter: NumberFormatter) {
        self.numberFormatter = formatter
    }
    
    func string(from minorUnits: Int, currencyCode: String) -> String? {
        let decimal = NSDecimalNumber.decimal(from: minorUnits)
        numberFormatter.currencyCode = currencyCode
        return numberFormatter.string(from: decimal as NSNumber)
    }
}
