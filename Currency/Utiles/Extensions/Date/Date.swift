import Foundation

extension Date {
    func getStringDateThreeDaysAgo(from: Int) -> String? {
        guard let threeDaysAgoDate = Calendar.current.date(
           byAdding: .day,
           value: -from,
           to: self) else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: threeDaysAgoDate)
    }
}
