//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александра Савчук on 30.09.2022.
//

import UIKit
class ProfileHeaderView: UIView {
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aleksandra"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.masksToBounds = false
        
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width: 5, height: 5))
        textField.leftViewMode = .always
        textField.leftView = spacerView
        textField.placeholder = " Type your status here"
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self, action: #selector(self.statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 182),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -10),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -56),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        guard let status = statusTextField.text else {return}
        if !status.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.statusLabel.text = self.statusTextField.text
                self.statusTextField.text = .none
                print("The status is - \(self.statusLabel.text!)")
            } completion: { _ in
            }
        } else {
            statusTextField.shake()
            print("The status is not set")
        }
        endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        let statusText = statusTextField.text
        statusLabel.text = statusText
    }
}

// код с stackoverflow
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.4
        animation.values = [-10.0, 10.0, -5.0, 5.0, -5.0, 5.0, -2.0, 2.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
