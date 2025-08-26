import SwiftUI

struct BannerView: View {
    let banner: HomeBanner
    
    var body: some View {
        Image(banner.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(banner: HomeBanner.sampleBanners[0])
            .padding()
    }
}
