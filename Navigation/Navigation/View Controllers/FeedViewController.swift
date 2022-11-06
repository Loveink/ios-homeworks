//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 29.09.2022.
//

import UIKit

class FeedViewController: UIViewController {
    var postOne = "POST"
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var postButtonOne: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.goToPost), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 12
        button.setTitle("Go to post 1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var postButtonTwo: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.goToprofile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 12
        button.setTitle("Go to profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.setupView().self
    }
    private func setupView() {
        self.view.addSubview(self.verticalStackView)
        self.verticalStackView.addArrangedSubview(postButtonOne)
        self.verticalStackView.addArrangedSubview(postButtonTwo)
        self.verticalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.verticalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.verticalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        self.verticalStackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.postButtonOne.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor).isActive = true
        self.postButtonOne.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor).isActive = true
        self.postButtonOne.topAnchor.constraint(equalTo: self.verticalStackView.topAnchor).isActive = true
        self.postButtonTwo.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor).isActive = true
        self.postButtonTwo.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor).isActive = true
    }
    
    @objc func goToPost(sender:UIButton!)  {
        let postViewController  = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        self.navigationItem.backButtonTitle = "Back"
    }
    @objc func goToprofile(sender:UIButton!)  {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
