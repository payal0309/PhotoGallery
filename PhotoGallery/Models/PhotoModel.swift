//
//  PhotoModel.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 12/01/24.
//

import Foundation

struct PhotoModel: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let downloadUrl: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height
        case downloadUrl = "download_url"
    }
}
