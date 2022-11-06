//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александра Савчук on 07.10.2022.
//

import UIKit

class LogInViewController: UIViewController, UIScrollViewDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var logoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray6
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.delegate = self
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Email or phone"
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "Password"
        textField.layer.borderWidth = 0.5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        switch button.state {
        case .normal: button.alpha = 1
        case .selected, .highlighted, .disabled: button.alpha = 0.8
        default:
            button.alpha = 1
        }
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.showProfileVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.isHidden = true
        errorLabel.text = ""
        errorLabel.font = .systemFont(ofSize: 11, weight: .bold)
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    @objc func showProfileVC(){
        if checkText() {
            let profileVC = ProfileViewController()
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkText() -> Bool {
        if loginTextField.text == "" {
            loginTextField.backgroundColor = .systemRed
            return false
        } else {
            loginTextField.backgroundColor = .none
        }
        if passwordTextField.text == "" {
            passwordTextField.backgroundColor = .systemRed
            return false
        } else {
            passwordTextField.backgroundColor = .none
        }
        if loginTextField.text!.count < 5 {
            errorLabel.text = "Логин содержит менее 5 символов"
            errorLabel.isHidden = false
            loginTextField.shake()
            return false
        } else {
            errorLabel.isHidden = true
        }
        if passwordTextField.text!.count < 5 {
            errorLabel.text = "Пароль содержит менее 5 символов"
            errorLabel.isHidden = false
            passwordTextField.shake()
            return false
        } else {
            errorLabel.isHidden = true
        }
        return checkLoginAndPassword() ? true : false
    }
    
    func checkLoginAndPassword() -> Bool {
        if let email = loginTextField.text {
            if isValidEmail(email) {
                if loginTextField.text == "login@mail.ru" && passwordTextField.text == "12345" {
                    return true
                } else {
                    let ac = UIAlertController(title: "Ошибка!", message: "Логин по умолчанию login@mail.ru и пароль 12345", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    present(ac, animated: true, completion: nil)
                    return false
                }
            }
            
        } else {
        }
        let ac = UIAlertController(title: "Ошибка!", message: "Email не прошел валидацию", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subviews()
        setupConstraints()
        self.navigationController?.navigationBar.isHidden = true
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        addTapGestureToHideKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    private func subviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logInButton)
        contentView.addSubview(logoView)
        contentView.addSubview(loginPasswordStackView)
        loginPasswordStackView.addArrangedSubview(loginTextField)
        loginPasswordStackView.addArrangedSubview(passwordTextField)
        contentView.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            
            loginPasswordStackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            loginPasswordStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginPasswordStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: loginPasswordStackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.bottomAnchor.constraint(equalTo: loginPasswordStackView.topAnchor, constant: -16),
            errorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            errorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
    
    @objc func buttonClicked() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let heightOfContent = loginPasswordStackView.bounds.height + logInButton.bounds.height + logInButton.bounds.height + 256
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                let frame = self.view.safeAreaLayoutGuide.layoutFrame
                let contentOffset: CGPoint = notification.name == UIResponder.keyboardWillHideNotification ? .zero: CGPoint(x: 0, y: heightOfContent - keyboardHeight)
                if heightOfContent + keyboardHeight >= frame.height {
                    self.scrollView.contentOffset = contentOffset
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension LogInViewController: UITextFieldDelegate {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
