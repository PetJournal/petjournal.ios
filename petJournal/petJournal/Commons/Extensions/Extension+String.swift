import Foundation

extension String {
    func calculateAge() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let birthDate = dateFormatter.date(from: self) else {
            return "Idade desconhecida"
        }
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year, .month], from: birthDate, to: Date())
        
        if let years = ageComponents.year, years > 0 {
            return "\(years) ano\(years > 1 ? "s" : "")"
        } else if let months = ageComponents.month, months > 0 {
            return "\(months) mês\(months > 1 ? "es" : "")"
        } else {
            return "Recém-nascido"
        }
    }

    var toDayMonthFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "pt_BR")
        
        guard let date = formatter.date(from: self) else { return "Data inválida" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd 'de' MMM"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        
        return outputFormatter.string(from: date)
    }
    
    var toWeekRangeFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "pt_BR")
        
        guard let date = formatter.date(from: self) else { return "Data inválida" }
        
        let calendar = Calendar.current
        let week = calendar.component(.weekOfMonth, from: date)
        
        let dayMonthFormatter = DateFormatter()
        dayMonthFormatter.dateFormat = "dd 'of' MMM"
        dayMonthFormatter.locale = Locale(identifier: "pt_BR")
        
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        
        return "Semana \(week): \(dayMonthFormatter.string(from: weekStart)) - \(dayMonthFormatter.string(from: weekEnd))"
    }
    
    var toMonthYearFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "pt_BR")
        
        guard let date = formatter.date(from: self) else { return "Data inválida" }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM, yyyy"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        
        return outputFormatter.string(from: date)
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self)
    }
    
    func toISOFormat() -> String {
        guard let date = self.toDate() else { return self }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter.string(from: date)
    }
    
    func toISOWeekFormat() -> String {
        guard let date = self.toDate() else { return self }
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        return "\(calendar.component(.year, from: date))-W\(weekOfYear)"
    }
    
    func toISOMonthFormat() -> String {
        guard let date = self.toDate() else { return self }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return "\(year)-\(month)"
    }
    
    func isDateInThePast() -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: self) else {
            return false
        }
        return date < Date()
    }
    
    func toAPIDateFormat() -> String? {
        guard !self.trimmed.isEmpty else { return nil }
         
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd/MM/yyyy"
         dateFormatter.locale = Locale(identifier: "pt_BR")
         dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
         
         guard let date = dateFormatter.date(from: trimmed) else { return nil }
         
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
         outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
         outputFormatter.locale = Locale(identifier: "en_US_POSIX")
         
         return outputFormatter.string(from: date)
     }
}
