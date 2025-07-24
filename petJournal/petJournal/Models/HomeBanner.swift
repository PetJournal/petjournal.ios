import Foundation

struct HomeBanner: Codable, Identifiable {
    let id: Int
    let image: String
    let title: String?
    let subtitle: String?
    let actionURL: String?
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, image, title, subtitle
        case actionURL = "action_url"
        case isActive = "is_active"
    }
}

extension HomeBanner {
    static var sampleBanners: [HomeBanner] {
        return [
            HomeBanner(
                id: 1,
                image: "banner_01",
                title: "Promoção de Verão",
                subtitle: "Descontos de até 50%",
                actionURL: "app://promo/summer",
                isActive: true
            ),
            HomeBanner(
                id: 2,
                image: "banner_02",
                title: "Novidades",
                subtitle: "Confira nossos lançamentos",
                actionURL: "app://products/new",
                isActive: true
            ),
            HomeBanner(
                id: 3,
                image: "banner_03",
                title: nil,
                subtitle: nil,
                actionURL: nil,
                isActive: false
            )
        ]
    }
}
