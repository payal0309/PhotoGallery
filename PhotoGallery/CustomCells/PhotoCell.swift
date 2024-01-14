//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 12/01/24.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PhotoCell"
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configureCell(with imageURL: URL, cellWidth:CGFloat) {
        
        // Load image from URL asynchronously
        let thumbNailUrl =  URL(string: imageURL.absoluteString)?.replacingPathComponents(at: [3, 4], with: cellWidth)
        print("thumbnail URL\(thumbNailUrl?.absoluteString ?? imageURL.absoluteString )")
        imageView.loadImageAndCachingFor(url:thumbNailUrl)
    }
}


