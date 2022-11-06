//
//  Structs.swift
//  Navigation
//
//  Created by Александра Савчук on 29.09.2022.
//
import UIKit

struct Post {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
    let id: String?
}
var arrayOfposts: [Post] = []

enum nameOfPhotos: String {
    case cat1, cat2, cat3, cat4, cat5, cat6, cat7, cat8, cat9, cat10,
         cat11, cat12, cat13, cat14, cat15, cat16, cat17, cat18, cat19, cat20
}

class CustomPhotoView {
    var nameOfPhoto = nameOfPhotos.cat1
    init(nameOfPhoto: nameOfPhotos) {
        self.nameOfPhoto = nameOfPhoto
    }
    func doImageView() -> UIImageView {
        let imageView = UIImageView()
        let image = UIImage(named: nameOfPhoto.rawValue)
            imageView.image = image
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 6
            imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}

let arrayOfPhotos : [CustomPhotoView] = [
    CustomPhotoView(nameOfPhoto: .cat1),
    CustomPhotoView(nameOfPhoto: .cat2),
    CustomPhotoView(nameOfPhoto: .cat3),
    CustomPhotoView(nameOfPhoto: .cat4),
    CustomPhotoView(nameOfPhoto: .cat5),
    CustomPhotoView(nameOfPhoto: .cat6),
    CustomPhotoView(nameOfPhoto: .cat7),
    CustomPhotoView(nameOfPhoto: .cat8),
    CustomPhotoView(nameOfPhoto: .cat9),
    CustomPhotoView(nameOfPhoto: .cat10),
    CustomPhotoView(nameOfPhoto: .cat11),
    CustomPhotoView(nameOfPhoto: .cat12),
    CustomPhotoView(nameOfPhoto: .cat13),
    CustomPhotoView(nameOfPhoto: .cat14),
    CustomPhotoView(nameOfPhoto: .cat15),
    CustomPhotoView(nameOfPhoto: .cat16),
    CustomPhotoView(nameOfPhoto: .cat17),
    CustomPhotoView(nameOfPhoto: .cat18),
    CustomPhotoView(nameOfPhoto: .cat19),
    CustomPhotoView(nameOfPhoto: .cat20),
]
protocol TapLikedDelegate: AnyObject {
    func tapLikedLabel()
}
