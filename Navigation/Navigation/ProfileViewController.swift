//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 29.09.2022.
//

import UIKit

class ProfileViewController: UIViewController, TapLikedDelegate {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var liked: Bool = false
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupViewTableView()
        self.addPosts()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.systemGray6
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupViewTableView() {
        
        view.addSubview(tableView)
        view.addSubview(backView)
        backView.contentView.addSubview(avatarImageView)
        backView.contentView.addSubview(xMark)
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        backView.effect = blur
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            
            xMark.heightAnchor.constraint(equalToConstant: 60),
            xMark.widthAnchor.constraint(equalToConstant: 60),
            xMark.topAnchor.constraint(equalTo:  backView.safeAreaLayoutGuide.topAnchor, constant: 16),
            xMark.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupGesture() {
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapGesture(_ :)))
        profileHeaderView.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer){
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.backView.alpha = 1
            self.avatarImageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
            self.avatarImageView.transform = CGAffineTransform(scaleX: self.backView.frame.width / 150, y: self.backView.frame.width / 150)
            self.avatarImageView.layer.borderWidth = 0.4
            self.avatarImageView.layer.cornerRadius = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.xMark.alpha = 1
            }
        }
    }
    
    @objc private func didTapXButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.xMark.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.avatarImageView.transform = .identity
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
                self.backView.alpha = 0
            } completion: { _ in
                self.avatarImageView.alpha = 0
            }
        }
    }
    
    func tapLikedLabel() {
        liked.toggle()
        self.tableView.reloadData()
    }
    
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfposts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.likedDelegate = self
            if liked {
                arrayOfposts[indexPath.row - 1].likes += 1
                liked.toggle()
            }

            let post = arrayOfposts[indexPath.row - 1]
            let viewModel = Post(author: post.author,
                                 description: post.description,
                                 image: post.image,
                                 likes: post.likes,
                                 views: post.views,
                                 id: post.id)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView (_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = profileHeaderView
        headerView.backgroundColor = .lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else {
            let viewController = OpenPostViewController()
            viewController.selectedDataImage = arrayOfposts[indexPath.row - 1].image
            viewController.selectedDataLikes = arrayOfposts[indexPath.row - 1].likes
            viewController.selectedDataViews = arrayOfposts[indexPath.row - 1].views + 1
            viewController.selectedDataAuthor = arrayOfposts[indexPath.row - 1].author
            viewController.selectedDataDescription = arrayOfposts[indexPath.row - 1].description
            viewController.selectedId = arrayOfposts[indexPath.row - 1].id
            arrayOfposts[indexPath.row - 1].views += 1
            self.tableView.reloadRows(at: [indexPath], with: .none)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            if indexPath.row != 0 {
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
                    (contextualAction, view, boolValue) in
                    arrayOfposts.remove(at: indexPath.row - 1)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
                return swipeActions
            }
            else { return nil }
        }
    }


extension ProfileViewController {
    
    private func addPosts() {
        arrayOfposts.append(.init(author: "Kitty One",
                                  description: "Замуууурчательный день",
                                  image: "kitty1",
                                  likes: 11,
                                  views: 400,
                                  id: "1"))
        arrayOfposts.append(.init(author: "Kitty Two",
                                  description: "Без кота и жизнь не та!",
                                  image: "kitty2",
                                  likes: 35,
                                  views: 200,
                                  id: "2"))
        arrayOfposts.append(.init(author: "Kitty Three",
                                  description: "Сплю когда захочу =)",
                                  image: "kitty3",
                                  likes: 87,
                                  views: 699,
                                  id: "3"))
        arrayOfposts.append(.init(author: "The best little kitty ever... blablablabla",
                                  description: "Быть котиком - классно!",
                                  image: "kitty4",
                                  likes: 37,
                                  views: 4000,
                                  id: "4"))
    }
}
