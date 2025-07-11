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
}
