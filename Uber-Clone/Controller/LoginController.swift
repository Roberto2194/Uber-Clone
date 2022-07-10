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
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        
        view.addSubview(emailImageView)
        emailImageView.anchor(left: view.leftAnchor, paddingLeft: 8,
                              centerY: view.centerYAnchor, width: 24, height: 24)
        
        view.addSubview(emailTextField)
        emailTextField.anchor(bottom: view.bottomAnchor, left: emailImageView.rightAnchor, right: view.rightAnchor,
                              paddingBottom: 8, paddingLeft: 8, centerY: view.centerYAnchor)
        
        view.addSubview(separatorView)
        separatorView.anchor(bottom: view.bottomAnchor, left: view.leftAnchor,
                             right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }()
    
    private let emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_mail_outline_white_2x")
        imageView.alpha = 0.87
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor : UIColor.lightGray])
        return textField
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .defaultBackgroundColor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor)
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                  paddingTop: 40, paddingLeft: 16, paddingRight: 16, height: 50)
    
    }
    
    // MARK: - Functions
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
