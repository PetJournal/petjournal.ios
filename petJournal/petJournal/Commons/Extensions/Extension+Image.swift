import SwiftUI

extension Image {
    // Initialize a image using its name from Asset Catalog
    init(asset: ImageAsset) {
        self.init(asset.rawValue)
    }
    
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        
        guard let view = controller.view else { return nil }
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
}
