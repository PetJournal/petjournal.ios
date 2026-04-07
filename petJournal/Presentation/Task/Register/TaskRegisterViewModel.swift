import SwiftUI

class TaskRegisterViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isSuccessAlert = false
    
    @Published var selectedTaskType: TaskType?
    @Published var taskName = ""
    @Published var taskDescription = ""
    @Published var selectedPets: Set<String> = []
    @Published var availablePets: [PetModel] = []
    @Published var isRecurrent = true
    @Published var selectedDate = Date()
    @Published var selectedMonths: Set<Int> = []
    @Published var selectedWeekDays: Set<Int> = []
    @Published var observation = ""
    
    /// Computed property to extract day component from selectedDate
    var selectedDay: Int {
        Calendar.current.component(.day, from: selectedDate)
    }
    
    // MARK: - Private Properties
    private let service: TaskRegisterServiceProtocol
    private let petService: PetServiceProtocol
    
    var taskTypes: [TaskType] { [.vaccine, .consultation, .medicine] }
    
    /// Validates if all required fields are filled
    var isValid: Bool {
        guard let _ = selectedTaskType,
              !taskName.isEmpty,
              !taskDescription.isEmpty,
              !selectedPets.isEmpty else {
            return false
        }
        
        if isRecurrent {
            if selectedMonths.isEmpty && selectedWeekDays.isEmpty {
                return false
            }
        }
        
        return true
    }
    
    // MARK: - Initialization
    init(service: TaskRegisterServiceProtocol = TaskService(), petService: PetServiceProtocol = PetService()) {
        self.service = service
        self.petService = petService
    }
    
    // MARK: - Public Methods
    
    /// Fetches available pets from the API
    func fetchPets() async {
        do {
            let pets = try await petService.fetch()
            await MainActor.run {
                availablePets = pets
            }
        } catch {
            // Silently fail, keep empty list
        }
    }
    
    /// Loads available pets into the view model
    func loadPets(_ pets: [PetModel]) {
        availablePets = pets
    }
    
    /// Toggles selection state of a specific pet
    func togglePetSelection(_ petId: String) {
        if selectedPets.contains(petId) {
            selectedPets.remove(petId)
        } else {
            selectedPets.insert(petId)
        }
    }
    
    /// Selects all available pets
    func selectAllPets() {
        selectedPets = Set(availablePets.map { $0.id })
    }
    
    /// Toggles selection state of a specific month for monthly recurrence
    func toggleMonth(_ month: Int) {
        if selectedMonths.contains(month) {
            selectedMonths.remove(month)
        } else {
            selectedMonths.insert(month)
        }
    }
    
    /// Saves the task by calling the registration service
    func save() async {
        guard isValid else { return }
        
        await setLoading(true)
        
        do {
            let request = buildRequest()
            let savedTask = try await service.register(request)
            await handleSuccess(savedTask)
        } catch {
            await handleError(error)
        }
    }
    
    /// Resets all form fields to their initial state
    func clear() {
        selectedTaskType = nil
        taskName = ""
        taskDescription = ""
        selectedPets.removeAll()
        isRecurrent = true
        selectedDate = Date()
        selectedMonths.removeAll()
        selectedWeekDays.removeAll()
        observation = ""
    }
}

// MARK: - Private Methods
private extension TaskRegisterViewModel {
    /// Builds the API request object from current form state
    func buildRequest() -> TaskRegisterRequest {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: selectedDate)
        let minute = calendar.component(.minute, from: selectedDate)
        let day = calendar.component(.day, from: selectedDate)
        
        let startDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
        let endDate = calendar.date(byAdding: .hour, value: 1, to: startDate) ?? startDate
        
        let daysOfWeek = Array(selectedWeekDays)
        let daysOfMonth = selectedMonths.isEmpty ? [] : [day]
        let isDaily = !isRecurrent || (selectedMonths.isEmpty && selectedWeekDays.isEmpty)
        
        return TaskRegisterRequest(
            tagId: getTagId(for: selectedTaskType ?? .vaccine),
            title: taskName,
            description: taskDescription,
            note: observation,
            startAt: formatDateToAPI(startDate),
            endAt: formatDateToAPI(endDate),
            daysOfWeek: daysOfWeek,
            daysOfMonth: daysOfMonth,
            daily: isDaily,
            pets: Array(selectedPets)
        )
    }
    
    /// Formats a Date object to ISO 8601 string format for API
    func formatDateToAPI(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
    
    /// Maps TaskType to corresponding tag ID for API
    func getTagId(for taskType: TaskType) -> String {
        switch taskType {
        case .vaccine: return "vaccine-tag-id"
        case .consultation: return "consultation-tag-id"
        case .medicine: return "medicine-tag-id"
        case .all: return ""
        }
    }
    
    @MainActor
    func setLoading(_ loading: Bool) {
        isLoading = loading
    }
    
    @MainActor
    func handleSuccess(_ task: PetTaskModel) {
        isLoading = false
        alertMessage = "Tarefa cadastrada com sucesso!"
        isSuccessAlert = true
        showAlert = true
    }
    
    @MainActor
    func handleError(_ error: Error) {
        isLoading = false
        alertMessage = "Erro ao cadastrar tarefa"
        isSuccessAlert = false
        showAlert = true
    }
}
