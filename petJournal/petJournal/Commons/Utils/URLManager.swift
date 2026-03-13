import Foundation

class URLManager {
    static let shared = URLManager()
    
    private init() {}
    
    let baseURL = "https://petjournal-api-pm3z.onrender.com/api"
    
    let loginURL = "/login"
    let signupURL = "/signup"
    let guardianChangePassword = "/guardian/change-password"
    let forgetPassword = "/forget-password"
    let waitingCode = "/waiting-code"
    let pet = "/pet"
    var breedsByCat = "/breeds/cat"
    var breedsByDog = "/breeds/dog"
    var sizesByCat = "/sizes/cat"
    var sizesByDog = "/sizes/dog"
    var petTasks = "/tasks/pet"
    
    var petUpdate: (String) -> String {
        { petId in "\(self.pet)/\(petId)" }
    }
    
    var deletePet: (String) -> String {
        { petId in "\(self.pet)/\(petId)" }
    }
    
    var petUpcomingTasks: (String) -> String {
        { petId in "\(self.petTasks)/next/\(petId)" }
    }
    
    var petHistoricTasks: (String) -> String {
        { petId in "\(self.petTasks)/history/\(petId)" }
    }
    
    func makeURL(path: String) -> URL? {
        guard let fullURL = URL(string: baseURL + path) else {
            return nil
        }
        return fullURL
    }
}
