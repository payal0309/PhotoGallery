//
//  PhotoApiService.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 12/01/24.
//

import Foundation

class PhotoApiService {
    
    let urlString = "https://jsonblob.com/api/jsonBlob/1182735235283804160"
    
    func getPhotoGalleryData(completion : @escaping ([PhotoModel]) -> ()){
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    // Handle error
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let photos = try decoder.decode([PhotoModel].self, from: data)
                    completion(photos)
                } catch {
                    // Handle decoding error
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
            
        }
    }
}
