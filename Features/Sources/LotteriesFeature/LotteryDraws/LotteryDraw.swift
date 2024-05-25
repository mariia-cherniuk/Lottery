import Foundation
import LotteriesDomain

struct LotteryDraw {

    private let dateFormat = "d MMMM yyyy"
    
    var id: String {
        lottery.id
    }
    
    var date: String {
        dateFormatter.newFormatStringDate(from: lottery.drawDate, newDateFormat: dateFormat) ?? "Unknown date"
    }
    
    var topPrize: String? {
        currencyFormatter.string(from: lottery.topPrize, currencyCode: currencyCode)
    }
    
    let lottery: Lottery
    private let dateFormatter: DateFormatter
    private let currencyFormatter: CurrencyFormatter
    private let currencyCode: String
    
    init(lottery: Lottery,
         dateFormatter: DateFormatter = .drawDateFormatter,
         formatter: NumberFormatter = .currency,
         currencyCode: String = "GBP") {
        self.lottery = lottery
        self.dateFormatter = dateFormatter
        self.currencyFormatter = CurrencyFormatter(formatter: formatter)
        self.currencyCode = currencyCode
    }
}
