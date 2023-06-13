import Foundation

extension Date {
    func getStringDateThreeDaysAgo() -> String? {
        guard let threeDaysAgoDate = Calendar.current.date(
           byAdding: .minute,
           value: -2,
           to: self) else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: threeDaysAgoDate)
    }
}