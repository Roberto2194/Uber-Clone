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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .defaultBackgroundColor

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor)
    }
    
    // MARK: - Functions
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
}
