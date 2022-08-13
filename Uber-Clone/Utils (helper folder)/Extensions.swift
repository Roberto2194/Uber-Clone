//
//  Extensions.swift
//  Uber-Clone
//
//  Created by Roberto on 09/07/22.
//

import UIKit

// MARK: - UIView

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingRight: CGFloat = 0,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerXConstant: CGFloat = 0,
                centerY: NSLayoutYAxisAnchor? = nil,
                centerYConstant: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    func inputContainerView(image: UIImageView, textField: UITextField) -> UIView {
        let view = UIView()
        view.anchor(height: 50)
        
        view.addSubview(image)
        image.anchor(left: view.leftAnchor, paddingLeft: 8, centerY: view.centerYAnchor, width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(bottom: view.bottomAnchor, left: image.rightAnchor, right: view.rightAnchor, paddingBottom: 8, paddingLeft: 8, centerY: view.centerYAnchor)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        view.addSubview(separatorView)
        separatorView.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
    
}

// MARK: - UIColor

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
}

// MARK: - UITextField

extension UITextField {
    
    func textField(withPlaceholder placeholder: String, isSecureTextEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.isSecureTextEntry = isSecureTextEntry
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor.lightGray])
        return textField
    }
    
    func locationTextField(withPlaceholder placeholder: String, backgroundColor: UIColor) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = backgroundColor
        textField.font = .systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.anchor(width: 8, height: 30)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }
    
}

// MARK: - UIImageView

extension UIImageView {
    
    func imageView(withName name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.alpha = 0.87
        return imageView
    }
    
}

//MARK: - UIStackView

extension UIStackView {
    
    func stackView(withArrangement subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 24
        return stackView
    }
    
}

//MARK: - UILabel

extension UILabel {
    
    func uberTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }
    
}

//MARK: - UIButton

extension UIButton {
    
    func button(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        button.backgroundColor = .mainBlueTint
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.anchor(height: 45)
        return button
    }
    
    func button(ofAccountType account: String, signType: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "\(account) ", attributes:
                                                            [.font : UIFont.systemFont(ofSize: 16),
                                                             .foregroundColor : UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: signType, attributes:
                                                    [.font : UIFont.boldSystemFont(ofSize: 16),
                                                     .foregroundColor : UIColor.mainBlueTint]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
