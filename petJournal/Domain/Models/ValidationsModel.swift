import Foundation

class ValidationsModel {
    static var shared = ValidationsModel()
    
    func validateInput(_ text: String, of type: Validations.ValidationType) -> Validations.ValidationError? {
        do {
            try Validations.shared.validate(text, type: type)
            return nil
        }
        catch let error {
            guard let error = error as? Validations.ValidationError else { return nil }
            return error
        }
    }
}
