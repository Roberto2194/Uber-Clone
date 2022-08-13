//
//  LocationInputView.swift
//  Uber-Clone
//
//  Created by Roberto on 13/08/22.
//

import UIKit

protocol LocationInputViewDelegate: AnyObject {
    func dismissLocationInputView()
}

class LocationInputView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LocationInputViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_arrow_back_black_36dp-1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        // TODO: - Instead of hardcoded text, the property label.text is gonna have wherever is the name of the user as its value
        label.text = "Roberto Liccardo"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let startingLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startingLocationTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        return UITextField().locationTextField(withPlaceholder: "Current location", backgroundColor: .systemGroupedBackground)
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .search
        return textField.locationTextField(withPlaceholder: "Enter a destination...", backgroundColor: .lightGray)
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        addSubview(backButton)
        // TODO: - Understand why the safe area is giving problems here
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12, width: 24, height: 24)
        
        addSubview(titleLabel)
        titleLabel.anchor(centerX: centerXAnchor, centerY: backButton.centerYAnchor)
        
        addSubview(startingLocationTextField)
        startingLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 40, paddingRight: 40, height: 30)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: startingLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)
        
        addSubview(startingLocationIndicatorView)
        startingLocationIndicatorView.anchor(left: leftAnchor, paddingLeft: 20, centerY: startingLocationTextField.centerYAnchor, width: 6, height: 6)
        startingLocationIndicatorView.layer.cornerRadius = 3
        
        addSubview(destinationLocationIndicatorView)
        destinationLocationIndicatorView.anchor(left: leftAnchor, paddingLeft: 20, centerY: destinationLocationTextField.centerYAnchor, width: 6, height: 6)

        addSubview(linkingView)
        linkingView.anchor(top: startingLocationIndicatorView.bottomAnchor, bottom: destinationLocationIndicatorView.topAnchor, paddingTop: 4, paddingBottom: 4, centerX: startingLocationIndicatorView.centerXAnchor, width: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc func handleBackTapped() {
        delegate?.dismissLocationInputView()
    }
    
}
