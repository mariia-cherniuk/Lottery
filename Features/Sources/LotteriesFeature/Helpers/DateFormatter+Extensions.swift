import Foundation

extension DateFormatter {
    
    static var drawDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    func newFormatStringDate(from stringDate: String, newDateFormat: String) -> String? {
        guard let date = self.date(from: stringDate) else { return nil }
        self.dateFormat = newDateFormat
        return self.string(from: date)
    }
}
