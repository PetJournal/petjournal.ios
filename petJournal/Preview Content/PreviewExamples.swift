import SwiftUI

// MARK: - Preview Examples
struct PreviewExamples {
    
    // Exemplo de como usar os mocks em previews
    static func petListPreview() -> some View {
        List(PetModel.previewList) { pet in
            VStack(alignment: .leading) {
                Text(pet.petName)
                    .font(.headline)
                Text("\(pet.specie.name) - \(pet.breed.name)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    static func taskListPreview() -> some View {
        List(PetTaskModel.previewList) { task in
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text(task.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
    }
    
    static func guardianPreview() -> some View {
        VStack {
            Text("\(PetGuardian.preview.firstName) \(PetGuardian.preview.lastName)")
                .font(.title2)
            Text(PetGuardian.preview.email)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview Providers Examples
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Usando mock individual
        PetDetailView(pet: .preview)
        
        // Usando lista de mocks
        PetListView(pets: .previewList)
        
        // Usando mock de tasks
        TaskListView(filterTag: nil)
        
        // Usando histórico de tasks
        TaskHistoryView(tasks: .previewHistoric)
        
        // Usando mocks filtrados
        TaskListView(filterTag: TagModel(id: "1", name: "Medicamento", color: "#FF0000"))
        PetListView(pets: .previewDogs)
    }
}
*/
