//
//  CollectionViewSetupHelper.swift
//  PhotoGallery
//
//  Created by Payal Bajoria on 13/01/24.
//

import UIKit

//struct CollectionViewLayoutInfo {
//    let cellWidth: CGFloat
//    let itemSize: CGSize
//}

class CollectionViewSetupHelper {
    
    static func setupCollectionView(in view: UIView, delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, numberOfColumns: Int, cellWidth: inout CGFloat) -> UICollectionView {
        
        let screenWidth = UIScreen.main.bounds.width
        
        cellWidth = (screenWidth - CGFloat(numberOfColumns + 1) * 1.5) / CGFloat(numberOfColumns)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1.5
        layout.minimumInteritemSpacing = 1
        layout.itemSize =  CGSize(width: cellWidth, height: cellWidth)

        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)

        // Add constraints for the collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        return collectionView
    }
}
