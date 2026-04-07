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
    let guardianName = "/guardian/name"
    let pet = "/pet"
    let tag = "/tag"
    let tasks = "/tasks"
    let scheduler = "/scheduler"
    var breedsByCat = "/breeds/cat"
    var breedsByDog = "/breeds/dog"
    var sizesByCat = "/sizes/cat"
    var sizesByDog = "/sizes/dog"
    
    var currentDateTasks: String {
        "\(tasks)/current-date"
    }
    
    var currentWeekTasks: String {
        "\(tasks)/current-week"
    }
    
    var currentMonthTasks: String {
        "\(tasks)/current-month"
    }
    
    var petUpdate: (String) -> String {
        { petId in "\(self.pet)/\(petId)" }
    }
    
    var deletePet: (String) -> String {
        { petId in "\(self.pet)/\(petId)" }
    }
    
    var petUpcomingTasks: (String) -> String {
        { petId in "\(self.tasks)/pet/next/\(petId)" }
    }
    
    var petHistoricTasks: (String) -> String {
        { petId in "\(self.tasks)/pet/history/\(petId)" }
    }
    
    var petTasksByTag: (String, String) -> String {
        { petId, tagId in "\(self.tasks)/pet/\(petId)/tag/\(tagId)" }
    }
    
    func makeURL(path: String) -> URL? {
        guard let fullURL = URL(string: baseURL + path) else {
            return nil
        }
        return fullURL
    }
}
