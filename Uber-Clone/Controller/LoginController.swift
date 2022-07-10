//
//  LoginController.swift
//  Uber-Clone
//
//  Created by kalpa on 07/07/22.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()
    
    private let emailImageView: UIImageView = {
        return UIImageView().imageView(withName: "ic_mail_outline_white_2x")
    }()
    
    private let passwordImageView: UIImageView = {
        return UIImageView().imageView(withName: "ic_lock_outline_white_2x")
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email")
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private lazy var emailContainerView: UIView = {
        return UIView().inputContainerView(image: emailImageView, textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: UIView = {
        return UIView().inputContainerView(image: passwordImageView, textField: passwordTextField)
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.backgroundColor = .mainBlueTint
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(withArrangement: [emailContainerView, passwordContainerView, loginButton])
    }()
    
    private let noAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes:
                                                                                        [.font : UIFont.systemFont(ofSize: 16),
                                                                                        .foregroundColor : UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes:
                                                                    [.font : UIFont.boldSystemFont(ofSize: 16),
                                                                    .foregroundColor : UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        configureNavigationBar()
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor)
            
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(noAccountButton)
        noAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor, height: 32)
    }
        
    // MARK: - Functions

    @objc private func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
            
}
