//
//  ImageView.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 12/01/24.
//

import Foundation

// Extension to load image from URL asynchronously
import UIKit

extension UIImageView {
    
    private static var imageCache = NSCache<NSURL, UIImage>()

    func loadImageAndCachingFor(url: URL?, completion: (() -> Void)? = nil) {
        guard let url = url else { return }

        // Check if the image is already in the cache
        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            completion?()
            return
        }

        // If not in the cache, download the image and store it in the cache
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error loading image from URL: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let image = UIImage(data: data) {
                // Store the image in the cache
                UIImageView.imageCache.setObject(image, forKey: url as NSURL)

                DispatchQueue.main.async {
                    self.image = image
                    completion?()
                }
            }
        }.resume()
    }

}
