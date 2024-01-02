import SwiftUI

struct BannerView: View {
    let banner: HomeModel
    
    var body: some View {
        Image(banner.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}
