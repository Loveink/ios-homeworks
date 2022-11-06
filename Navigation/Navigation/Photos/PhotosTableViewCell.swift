//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Александра Савчук on 19.10.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightArrow: UIImageView = {
        let rightArrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
        imageView.image = rightArrow
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(backView)
        backView.addSubview(photoLabel)
        backView.addSubview(rightArrow)
        backView.addSubview(photoStackView)
        photoStackView.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            photoLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            photoLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 12),
            
            rightArrow.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            rightArrow.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),
            rightArrow.heightAnchor.constraint(equalTo: photoLabel.heightAnchor),
            rightArrow.widthAnchor.constraint(equalTo: rightArrow.heightAnchor, multiplier: 1),
            
            photoStackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            photoStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12),
            photoStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            photoStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),
            
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.25)
        ])
    }
    // реализую collection view для прокрутки маленьких фото
    enum Constants {
        static let itemCount: CGFloat = 4
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
}
