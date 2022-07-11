//
//  LogInController.swift
//  Uber-Clone
//
//  Created by Roberto on 07/07/22.
//

import UIKit

class LogInController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        return UILabel().uberTitleLabel()
    }()
    
    private let emailImageView: UIImageView = {
        return UIImageView().imageView(withName: "logInControllerEmailImageView".localized)
    }()
    
    private let passwordImageView: UIImageView = {
        return UIImageView().imageView(withName: "logInControllerPasswordImageView".localized)
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "logInControllerEmailTextField".localized)
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "logInControllerPasswordTextField".localized, isSecureTextEntry: true)
    }()
    
    private lazy var emailContainerView: UIView = {
        return UIView().inputContainerView(image: emailImageView, textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: UIView = {
        return UIView().inputContainerView(image: passwordImageView, textField: passwordTextField)
    }()
    
    private let loginButton: UIButton = {
        return UIButton().button(withTitle: "logInControllerLoginButton".localized)
    }()
    
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(withArrangement: [emailContainerView, passwordContainerView, loginButton])
    }()
    
    private let noAccountButton: UIButton = {
        let button = UIButton().button(ofAccountType: "logInControllerNoAccountButtonOfAccountType".localized, signType: "logInControllerNoAccountButtonSignType".localized)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
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
