import SwiftUI

struct FeatureTabView: View {
    let banners: [HomeBanner]
    
    var body: some View {
        TabView {
            ForEach(banners) { banner in
                BannerView(banner: banner)
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct FeatureTabView_Previews: PreviewProvider {
    static var previews: some View {
        return FeatureTabView(banners: HomeBanner.sampleBanners)
            .padding()
    }
}
