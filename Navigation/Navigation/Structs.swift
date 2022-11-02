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
}

struct PhotosViewModel {
    var image: String = ""
    init(image: String) {
        self.image = image
    }
}

struct ViewModel {
    var author: String
    var description: String
    var image: UIImage?
    var likes: Int
    var views: Int
}

