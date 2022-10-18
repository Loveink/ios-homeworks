//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 29.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var arrayOfposts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupViewTableView()
        self.addPosts()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Feed"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.black
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupViewTableView() {
        view.backgroundColor = .systemGray6
        view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
       tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
       tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
       tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
       tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addPosts() {
        self.arrayOfposts.append(.init(author: "Kitty One",
                                       description: "Замуууурчательный день",
                                       image: "kitty1",
                                       likes: 11,
                                       views: 400))
        self.arrayOfposts.append(.init(author: "Kitty Two",
                                       description: "Без кота и жизнь не та!",
                                       image: "kitty2",
                                       likes: 35,
                                       views: 200))
        self.arrayOfposts.append(.init(author: "Kitty Three",
                                       description: "Сплю когда захочу =)",
                                       image: "kitty3",
                                       likes: 87,
                                       views: 699))
        self.arrayOfposts.append(.init(author: "The best little kitty ever... blablablabla",
                                       description: "Быть котиком - классно!",
                                       image: "kitty4",
                                       likes: 37,
                                       views: 4000))
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfposts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let post = self.arrayOfposts[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: post.author,
                                                    description: post.description,
                                                    image: UIImage(named: post.image),
                                                    likes: post.likes,
                                                    views: post.views)
        cell.setup(with: viewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =  profileHeaderView
        headerView.backgroundColor = .systemGray6
        headerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return headerView
    }
}

