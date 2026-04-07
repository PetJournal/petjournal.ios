import SwiftUI
import WebKit

struct WebView: View {
    var link: String
    
    var body: some View {
        ZStack {
            WebViewContainer(url: URL(string: link)!)
        }
    }
}

struct WebViewContainer: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
