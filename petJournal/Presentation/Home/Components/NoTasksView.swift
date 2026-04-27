import SwiftUI

struct NoTasksView: View {
    @State private var showingAddTask = false
    
    let title: String
    let subtitle: String
    let buttonTitle: String
    let image: Image

    init(
        title: String = "Você não tem nenhuma tarefa!",
        subtitle: String = "Crie tarefas para organizar o seu dia",
        buttonTitle: String = "Criar tarefa",
        image: Image = Image(.tasks)
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        self.image = image
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.robotoMedium(size: .medium))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.robotoLight(size: .small))
                    .foregroundColor(.secondary)
                
                PJButton.primary(buttonTitle, action: { showingAddTask = true })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
        .sheet(isPresented: $showingAddTask) {
            NavigationStack {
                TaskRegisterView()
            }
        }
    }
}

struct NoTasksView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NoTasksView()
            NoTasksView(
                title: "Sem tarefa",
                subtitle: "Descrição personalizada",
                buttonTitle: "+ Tarefa",
                image: Image(.imgDogAndCat)
            )
        }
        .padding()
        .previewDisplayName("Padrão e customizado")
    }
}
