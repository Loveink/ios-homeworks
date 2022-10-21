//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 19.10.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private enum Constants {
        static let itemCount: CGFloat = 3
    }

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var arrayOfPhotos : [PhotosViewModel] = [
        PhotosViewModel(image: "1"),
        PhotosViewModel(image: "2"),
        PhotosViewModel(image: "3"),
        PhotosViewModel(image: "4"),
        PhotosViewModel(image: "5"),
        PhotosViewModel(image: "6"),
        PhotosViewModel(image: "7"),
        PhotosViewModel(image: "8"),
        PhotosViewModel(image: "9"),
        PhotosViewModel(image: "10"),
        PhotosViewModel(image: "11"),
        PhotosViewModel(image: "12"),
        PhotosViewModel(image: "13"),
        PhotosViewModel(image: "14"),
        PhotosViewModel(image: "15"),
        PhotosViewModel(image: "16"),
        PhotosViewModel(image: "17"),
        PhotosViewModel(image: "18"),
        PhotosViewModel(image: "19"),
        PhotosViewModel(image: "20"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.navigationItem.title = "Photo Gallery"
        self.navigationItem.backButtonTitle = "Back"
        self.navigationController?.navigationBar.isHidden = false
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
            cell.backgroundColor = .systemGray6
            return cell
        }
        cell.backgroundColor = .systemGray6
        let photos = arrayOfPhotos[indexPath.row]
        cell.photoImagesToGallery.image = UIImage(named: photos.image)
        cell.photoImagesToGallery.contentMode = .scaleAspectFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
