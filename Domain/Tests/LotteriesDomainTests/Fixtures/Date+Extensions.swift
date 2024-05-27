import Foundation

extension Date {
    
    static func fixture(day: Int = 15, month: Int = 5, year: Int = 2023) -> Self {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        // Use the current calendar to create the date
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)!
    }
}
