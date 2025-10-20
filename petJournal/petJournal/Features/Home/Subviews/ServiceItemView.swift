import SwiftUI

struct ServiceItemView: View {
    let service: ServiceModel
    var itemHeight: CGFloat = 85
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            serviceIcon
            serviceName
        }
        .frame(width: itemHeight, height: itemHeight)
        .background(service.backgroundColor)
        .cornerRadius(16)
        .shadow(radius: 6, x: 2, y: 2)
        .padding(4)
    }
    
    private var serviceIcon: some View {
        service.image
            .foregroundColor(service.color)
            .frame(height: itemHeight / 2)
    }
    
    private var serviceName: some View {
        Text(service.name)
            .foregroundColor(service.color)
            .font(.robotoMedium(size: .small))
            .lineLimit(1)
            .truncationMode(.tail)
            .padding(2)
    }
}

struct ServiceItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(ServiceModel.mockServices) { service in
                    ServiceItemView(service: service)
                }
            }
            .padding()
        }.previewDisplayName("Lista de opções de serviços")
    }
}
