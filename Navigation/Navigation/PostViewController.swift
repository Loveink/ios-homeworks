//
//  PostViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 29.09.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let vc = FeedViewController()
        let title = vc.postOne.text
        self.navigationItem.title = title
        let infoButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func action(sender: UIBarButtonItem!) {
        let infoView = InfoViewController()
        self.navigationController?.present(infoView, animated: true, completion: nil)
    }
}
