//
//  PhotoViewModel.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 12/01/24.
//

import Foundation

protocol PhotoViewModelDelegate: AnyObject {
    func didUpdatePhotos()
    func didTapPhoto(at index: Int)
}


class PhotoViewModel:NSObject {

    weak var delegate: PhotoViewModelDelegate?
    private var apiService: PhotoApiService!
    private(set) var photoData: [PhotoModel] = [] {
        didSet {
            delegate?.didUpdatePhotos()
        }
    }
    var numberOfPhotos: Int {
        return photoData.count
    }

    override init() {
        super.init()
        self.apiService = PhotoApiService()
        getPhotosData()
        
    }
    
    // call APi service to get data
    func getPhotosData(){
        self.apiService.getPhotoGalleryData { photos in
            self.photoData = photos
        }
    }
    
    // convert photo string to url
    func photoURL(at index: Int) -> URL? {
        guard index < photoData.count else {
            return nil
        }
        return URL(string: photoData[index].downloadUrl)
    }

    // Delegates called
    
    func didSelectPhoto(at index: Int) {
        delegate?.didTapPhoto(at: index)
    }

}
