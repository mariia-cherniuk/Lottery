import Foundation
import LotteriesDomain
import Formatters

struct LotteryDraw {

    private let dateFormat = "d MMMM yyyy"
    
    var id: String {
        lottery.id
    }
    
    var date: String {
        dateFormatter.string(from: lottery.drawDate)
    }
    
    var topPrize: String? {
        currencyFormatter.string(from: lottery.topPrize, currencyCode: currencyCode)
    }
    
    let lottery: Lottery
    private let dateFormatter: DateFormatter
    private let currencyFormatter: CurrencyFormatter
    private let currencyCode: String
    
    init(lottery: Lottery,
         dateFormatter: DateFormatter = .monthDateFormatter,
         formatter: NumberFormatter = .currency,
         currencyCode: String = "GBP") {
        self.lottery = lottery
        self.dateFormatter = dateFormatter
        self.currencyFormatter = CurrencyFormatter(formatter: formatter)
        self.currencyCode = currencyCode
    }
}
