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
    
    private lazy var xMark: UIButton = {
        let xMark = UIButton()
        xMark.setImage(.init(systemName: "x.circle.fill"), for: .normal)
        xMark.alpha = 0
        xMark.tintColor = .systemBlue
        xMark.addTarget(self, action: #selector(self.didTapXButton), for: .touchUpInside)
        xMark.translatesAutoresizingMaskIntoConstraints = false
        xMark.isUserInteractionEnabled  = true
        return xMark
    }()
    
    var selectedImage: String?
    
    private lazy var backView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bigPhotoImage: UIImageView = {
        let imageView = UIImageView()
        if let image = selectedImage {
            imageView.image = UIImage(named: image)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
//
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
        view.addSubview(backView)
        backView.contentView.addSubview(bigPhotoImage)
        backView.contentView.addSubview(xMark)
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        backView.effect = blur
        self.navigationItem.backButtonTitle = "Back"
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bigPhotoImage.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            bigPhotoImage.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            bigPhotoImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            bigPhotoImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            
            xMark.heightAnchor.constraint(equalToConstant: 60),
            xMark.widthAnchor.constraint(equalToConstant: 60),
            xMark.topAnchor.constraint(equalTo:  backView.safeAreaLayoutGuide.topAnchor, constant: 16),
            xMark.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16)
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    @objc private func didTapXButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.xMark.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.backView.alpha = 0
            } completion: { _ in
                self.selectedImage = nil
            }
        }
    }
}
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
            cell.backgroundColor = .systemGray6
            return cell
        }
        cell.backgroundColor = .systemGray6
        let photos = arrayOfPhotos[indexPath.row]
        cell.photoImagesToGallery.image = UIImage(named: photos.nameOfPhoto.rawValue)
        cell.photoImagesToGallery.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photos = arrayOfPhotos[indexPath.row]
        selectedImage = photos.nameOfPhoto.rawValue
        if let image = selectedImage {
            bigPhotoImage.image = UIImage(named: image)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.backView.alpha = 1
            self.bigPhotoImage.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.xMark.alpha = 1
            }
        }
    }
    
}

