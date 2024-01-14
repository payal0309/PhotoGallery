//
//  URL.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 13/01/24.
//

import Foundation

extension URL {
    func replacingPathComponents(at indices: [Int], with newValue: CGFloat) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }

        // Get the path components from the URL
       var pathComponents = self.pathComponents
        for index in indices {
            if index >= 0 && index < pathComponents.count {
                pathComponents[index] = String(format: "%.0f", newValue)
            }
        }

        // Reconstruct the modified path
        urlComponents.path = "/" + pathComponents.dropFirst().joined(separator: "/")

        // Reconstruct the modified URL
        return urlComponents.url
    }
}
