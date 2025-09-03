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
        VStack(alignment: .leading, spacing: 0) {
            searchField
            optionsList
        }
        .onAppear { filteredItems = items }
        .onTapGesture { isExpanded = false }
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
        .background(searchFieldBackground)
    }
    
    private var optionsList: some View {
        Group {
            if isExpanded {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(filteredItems, id: \.self) { item in
                            optionRow(for: item)
                        }
                    }
                }
                .frame(height: min(CGFloat(filteredItems.count) * 44, 220))
                .background(optionsListBackground)
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
        Button(action: { isExpanded.toggle() }) {
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                .foregroundColor(Color.theme.petGray800)
        }
    }
    
    private var searchFieldBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(borderColor, lineWidth: 1)
    }
    
    private var optionsListBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .shadow(color: Color.theme.petBlack.opacity(0.1),
                    radius: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
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
        filterItems()
        if !isExpanded { isExpanded = true }
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
