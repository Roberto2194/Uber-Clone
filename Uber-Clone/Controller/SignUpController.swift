//
//  SignUpController.swift
//  Uber-Clone
//
//  Created by Roberto on 10/07/22.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        return UILabel().uberTitleLabel()
    }()
    
    private let emailImageView: UIImageView = {
        return UIImageView().imageView(withName: "ic_mail_outline_white_2x")
    }()
    
    private let fullNameImageView: UIImageView = {
        return UIImageView().imageView(withName: "ic_person_outline_white_2x")
    }()
    
    private let passwordImageView: UIImageView = {
        return UIImageView().imageView(withName: "ic_lock_outline_white_2x")
    }()
    
    private let accountTypeImageView: UIImageView = {
        return UIImageView().imageView(withName: "ic_account_box_white_2x")
    }()
    
    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Email")
    }()
    
    private let fullNameTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Full Name")
    }()
    
    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let accountTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Rider", "Driver"])
        segmentedControl.backgroundColor = .backgroundColor
        segmentedControl.tintColor = UIColor(white: 1, alpha: 0.87)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var emailContainerView: UIView = {
        return UIView().inputContainerView(image: emailImageView, textField: emailTextField)
    }()
    
    private lazy var fullNameContainerView: UIView = {
        return UIView().inputContainerView(image: fullNameImageView, textField: fullNameTextField)
    }()
    
    private lazy var passwordContainerView: UIView = {
        return UIView().inputContainerView(image: passwordImageView, textField: passwordTextField)
    }()
    
    private lazy var accountTypeContainerView: UIView = {
        let view = UIView()
        view.anchor(height: 70)
        
        view.addSubview(accountTypeImageView)
        accountTypeImageView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: -8, paddingLeft: 8, width: 24, height: 24)
        
        view.addSubview(accountTypeSegmentedControl)
        accountTypeSegmentedControl.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8, centerY: view.centerYAnchor, centerYConstant: 8)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        view.addSubview(separatorView)
        separatorView.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton().button(withTitle: "Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(withArrangement: [emailContainerView, fullNameContainerView, passwordContainerView, accountTypeContainerView, signUpButton])
    }()
    
    private let withAccountButton: UIButton = {
        let button = UIButton().button(ofAccountType: "Already have an account? ", signType: "Sign In")
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor)
        
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(withAccountButton)
        withAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor, height: 32)
    }
    
    //MARK: - Functions
    
    @objc private func handleSignUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let fullname = fullNameTextField.text else { return }
        let accountType = accountTypeSegmentedControl.selectedSegmentIndex
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = ["email": email, "fullname": fullname, "accountType": accountType] as [String : Any]
            
            let database = Database.database(url: "https://uber-clone-3a678-default-rtdb.europe-west1.firebasedatabase.app")
            database.reference().child("users").child(uid).updateChildValues(values) { error, reference in
                print("successfully registered user and saved data...")
            }
        }
    }
    
    @objc private func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
}
