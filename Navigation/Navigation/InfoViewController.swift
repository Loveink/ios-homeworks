//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 30.09.2022.
//
import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let alertButton = UIButton(type: .system) as UIButton
        alertButton.layer.cornerRadius = 12
        alertButton.clipsToBounds = true
        alertButton.backgroundColor = .red
        alertButton.setTitle("Show alert message", for: .normal)
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.addTarget(self, action: #selector(makeAlert), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(alertButton)
        alertButton.bottomAnchor.constraint(equalTo: self.view.lastBaselineAnchor, constant: -40).isActive = true
        alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        alertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemYellow
        
    }
    @objc func makeAlert(sender:UIButton?)  {
        let alertController = UIAlertController(title: "ALERT!", message: "ALERT!",
                                                preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default,
                                     handler: {(action:UIAlertAction!) in
            print("OK pressed!")
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel,
                                         handler: {(action:UIAlertAction!) in
            print("Cancel pressed!")
        })
    
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
