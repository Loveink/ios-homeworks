//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 29.09.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var postOne = Post(text: "POST ONE")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let uiButton = UIButton()
        self.view.addSubview(uiButton)
        
        uiButton.addAction(UIAction(handler: {_ in
            let postVS = PostViewController()
            self.navigationController?.pushViewController(postVS, animated: true)
        }), for: .touchUpInside)
        uiButton.setTitle("Go to post", for: .normal)
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.backgroundColor = .brown
        
        NSLayoutConstraint.activate([
            uiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        
        
        
    }
}
