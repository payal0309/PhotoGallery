//
//  FullScreenViewController.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 14/01/24.
//


import UIKit

class FullScreenViewController: UIViewController {
    
    var imageView: UIImageView!
    var selectedImageURL: URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        
        // Add tap gesture recognizer to close the photo view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePhotoView))
        view.addGestureRecognizer(tapGesture)
        
        setupConstraints()
                
        if let imageURL = selectedImageURL {
            imageView.loadImageAndCachingFor(url:imageURL)
        }
    }

    
    @objc func closePhotoView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

