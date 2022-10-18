//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Александра Савчук on 18.10.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var author: String
        var description: String
        var image: UIImage?
        var likes: Int
        var views: Int
    }
    
    private lazy var authorText: UITextView = {
        let authorText = UITextView()
        authorText.textColor = .black
        authorText.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorText.textContainer.maximumNumberOfLines = 2
        authorText.translatesAutoresizingMaskIntoConstraints = false
        authorText.isScrollEnabled = false
        return authorText
    }()
    
    private lazy var descriptionText: UITextView = {
        let descriptionText = UITextView()
        descriptionText.textColor = .systemGray
        descriptionText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.isScrollEnabled = false
        return descriptionText
    }()
    
    private lazy var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        postImage.translatesAutoresizingMaskIntoConstraints = false
        return postImage
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        authorText.text = nil
        descriptionText.text = nil
        postImage.image = nil
    }
    
    func setup(with viewModel: ViewModel) {
        authorText.text = viewModel.author
        descriptionText.text = viewModel.description
        postImage.image = viewModel.image
        likesLabel.text = "Likes: \(viewModel.likes)"
        viewLabel.text = "Views: \(viewModel.views)"
    }
    
    private func setupView() {
        addSubview(authorText)
        addSubview(descriptionText)
        addSubview(postImage)
        addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(likesLabel)
        stackViewHorizontal.addArrangedSubview(viewLabel)
        
        NSLayoutConstraint.activate([
            
            authorText.topAnchor.constraint(equalTo: self.topAnchor),
            authorText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            authorText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            postImage.topAnchor.constraint(equalTo: authorText.bottomAnchor),
            postImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            postImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            postImage.bottomAnchor.constraint(equalTo: descriptionText.topAnchor),
            
            descriptionText.bottomAnchor.constraint(equalTo: stackViewHorizontal.topAnchor),
            descriptionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            stackViewHorizontal.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewHorizontal.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
