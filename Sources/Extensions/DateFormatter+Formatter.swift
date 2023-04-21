import Core
import Foundation

extension DateFormatter {
    
    // MARK: Formatters
    
    static let dateOnly = {
        let formatter = DateFormatter()
        
        formatter.timeZone = .gmt
        formatter.dateFormat = .Format.yearMonthDay
        
        return formatter
    }()
    
    static let dateAndTime = {
        let formatter = DateFormatter()
        
        formatter.timeZone = .gmt
        formatter.dateFormat = .Format.dateAndTimeWithMicroseconds
        
        return formatter
    }()

}

// MARK: - String+Format

private extension String {
    enum Format {
        static let yearMonthDay = "yyyy-MM-dd"
        static let dateAndTimeWithMicroseconds = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    }
}