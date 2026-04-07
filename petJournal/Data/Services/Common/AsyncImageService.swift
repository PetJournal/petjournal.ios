import SwiftUI

struct AsyncImageService {
    /// Download an image from a URL and convert it to a UIImage.
    ///
    /// - Parameter url: The URL of the image.
    /// - Returns: A UIImage object or nil if an error occurs.
    static func asyncImage(from url: String) async throws -> UIImage? {
        guard let imageURL = URL(string: url) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        let dataImage = UIImage(data: data)
        return dataImage
    }
}
