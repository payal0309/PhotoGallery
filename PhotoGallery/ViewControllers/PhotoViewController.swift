//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 12/01/24.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var viewModel: PhotoViewModel!
    private let noOfColumns = 3 // Adjust the number as needed
    private var customCellWidth : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = PhotoViewModel()
        viewModel.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView = CollectionViewSetupHelper.setupCollectionView(in: view, delegate: self, dataSource: self, numberOfColumns: noOfColumns, cellWidth: &customCellWidth)
    }
    
    func openPhotoView(at index: Int) {
        guard let selectedImage = viewModel.photoURL(at: index) else {
            return
        }
        
        let fullScreenVC = FullScreenViewController()
        fullScreenVC.selectedImageURL = selectedImage
        
        // Set modal presentation style for full-screen display
        fullScreenVC.modalPresentationStyle = .fullScreen
        present(fullScreenVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        
        // Either Load placeholder image or clear previous image while waiting for lazy loading
        cell.imageView.image = nil
        
        // Load image only when cell becomes visible
        if let photoURL = viewModel.photoURL(at: indexPath.item) {
            print("Visible cells are \(indexPath.row)")
            cell.configureCell(with: photoURL, cellWidth: customCellWidth)
        }
        
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension PhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // Handle the tap on a thumbnail here
        viewModel.didSelectPhoto(at: indexPath.item)
    }
}

// MARK: - PhotoViewModelDelegate

extension PhotoViewController: PhotoViewModelDelegate {
    
    func didTapPhoto(at index: Int) {
        openPhotoView(at: index)
    }
    
    
    func didUpdatePhotos() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
