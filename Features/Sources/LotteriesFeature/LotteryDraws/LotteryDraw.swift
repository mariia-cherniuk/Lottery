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
    
    let lottery: Lottery
    let dateFormatter: DateFormatter
    
    init(lottery: Lottery, dateFormatter: DateFormatter = .drawDateFormatter) {
        self.lottery = lottery
        self.dateFormatter = dateFormatter
    }
}
