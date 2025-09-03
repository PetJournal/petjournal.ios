/// Um componente de seleção com funcionalidade de autocompletar.
///
/// `AutoCompleteSelect` permite aos usuários escolher um item de uma lista de strings,
/// com suporte para filtragem à medida que o usuário digita. O componente exibe um campo de texto
/// para entrada do usuário e uma lista expansível de opções filtradas.
///
/// Exemplo de uso:
/// ```
/// @State private var selectedCity: String?
/// let cities = ["São Paulo", "Rio de Janeiro", "Belo Horizonte"]
///
/// var body: some View {
///     AutoCompleteSelect(
///         selectedItem: $selectedCity,
///         items: cities,
///         placeholder: "Selecione uma cidade"
///     )
/// }
/// ```
///
/// - Parameters:
///   - selectedItem: Um binding para a string selecionada pelo usuário.
///   - items: Um array de strings que serão exibidas como opções.
///   - placeholder: O texto de placeholder exibido no campo de texto quando vazio.

import SwiftUI

struct AutoCompleteSelect: View {
    @Binding var selectedItem: String?
    let items: [String]
    let placeholder: String
    
    @State private var searchText: String = ""
    @State private var isExpanded: Bool = false
    @State private var filteredItems: [String] = []
    
    var borderColor: Color {
        isExpanded
        ? Color.theme.petPrimary500
        : Color.theme.petGray800.opacity(0.6)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            searchField
            optionsList
        }
        .onAppear { filteredItems = items }
    }
}

// MARK: - Subviews
private extension AutoCompleteSelect {
    private var searchField: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .onChange(of: searchText) { handleTextChange() }
            
            if selectedItem != nil {
                clearButton
            }
            
            toggleButton
        }
        .padding(.horizontal, 12)
        .background(fieldsBackground)
    }
    
    private var optionsList: some View {
        Group {
            if isExpanded && !filteredItems.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(filteredItems, id: \.self) { item in
                            optionRow(for: item)
                        }
                    }
                }
                .frame(height: min(CGFloat(filteredItems.count) * 44, 220))
                .background(fieldsBackground)
            }
        }
    }
    
    private var clearButton: some View {
        Button(action: clearSelection) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(Color.theme.petGray800)
        }
    }
    
    private var toggleButton: some View {
        Button(action: {
            if filteredItems.isEmpty && selectedItem != nil {
                // Se não há itens para mostrar, restaura a lista completa
                filteredItems = items.filter { $0 != selectedItem }
            }
            isExpanded.toggle()
        }) {
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                .foregroundColor(Color.theme.petGray800)
        }
    }
    
    private var fieldsBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.theme.petWhite)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
            .shadow(color: Color.theme.petPrimary500.opacity(0.2), radius: 10)
    }
}

// MARK: - Helper Methods
private extension AutoCompleteSelect {
    private func optionRow(for item: String) -> some View {
        Button(action: { selectItem(item) }) {
            Text(item)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func handleTextChange() {
        // Filtra normalmente, mas remove o item selecionado se existir
        let filtered = searchText.isEmpty
            ? items
            : items.filter { $0.lowercased().contains(searchText.lowercased()) }
        
        filteredItems = filtered.filter { $0 != selectedItem }
        
        // Só expande se houver itens para mostrar
        if !isExpanded && !filteredItems.isEmpty {
            isExpanded = true
        }
        
        // Se não há itens após a filtragem, fecha a lista
        if filteredItems.isEmpty {
            isExpanded = false
        }
    }
    
    private func filterItems() {
        filteredItems = searchText.isEmpty
            ? items
            : items.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    private func selectItem(_ item: String) {
        selectedItem = item
        searchText = item
        isExpanded = false
    }
    
    private func clearSelection() {
        selectedItem = nil
        searchText = ""
    }
}

// MARK: - Preview
struct AutoCompleteSelectDemoView: View {
    @State private var selectedItem: String?
    
    private let items = [
        "Maçã", "Banana", "Laranja", "Abacaxi", "Morango",
        "Pêssego", "Uva", "Melancia", "Kiwi", "Manga"
    ]
    
    var body: some View {
        VStack() {
            AutoCompleteSelect(
                selectedItem: $selectedItem,
                items: items,
                placeholder: "Selecione uma fruta"
            )
            .padding()
            
            if let item = selectedItem {
                Text("Item selecionado: \(item)")
            }
        }
    }
}

#Preview {
    AutoCompleteSelectDemoView()
}
