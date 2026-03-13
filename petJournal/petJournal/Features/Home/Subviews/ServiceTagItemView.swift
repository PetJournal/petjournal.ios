import SwiftUI

struct ServiceTagItemView: View {
    // MARK: - Properties
    let tag: TagModel
    private let itemSize: CGFloat = 85
    private let iconSize: CGFloat = 42
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            tagIcon
            tagLabel
        }
        .frame(width: itemSize, height: itemSize)
        .background(tag.backgroundColor)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 1, y: 2)
        .padding(4)
    }
}

// MARK: - View Components
private extension ServiceTagItemView {
    var tagIcon: some View {
        IconView(
            image: tag.image,
            color: tag.colorValue,
            size: iconSize
        )
    }
    
    var tagLabel: some View {
        TagLabel(
            text: tag.name,
            color: tag.colorValue
        )
    }
}

// MARK: - Supporting Views
struct IconView: View {
    let image: Image?
    let color: Color
    let size: CGFloat
    
    var body: some View {
        Group {
            if let image = image {
                image
            } else {
                Image(systemName: "tag.fill")
            }
        }
        .foregroundColor(color)
        .frame(width: size, height: size)
    }
}

struct TagLabel: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.robotoMedium(size: .small))
            .lineLimit(1)
            .truncationMode(.tail)
            .padding(.horizontal, 2)
    }
}

// MARK: - Preview
struct ServiceItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(TagModel.mockServices) { service in
                    ServiceTagItemView(tag: service)
                }
            }
            .padding()
        }.previewDisplayName("Lista de opções de serviços")
    }
}
