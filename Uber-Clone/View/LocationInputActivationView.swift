//
//  LocationInputActivationView.swift
//  Uber-Clone
//
//  Created by Roberto on 13/08/22.
//

import UIKit

protocol LocationInputActivationViewDelegate: AnyObject {
    func presentLocationInputView()
}

class LocationInputActivationView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: LocationInputActivationViewDelegate?
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addShadow()
        
        addSubview(indicatorView)
        indicatorView.anchor(left: leftAnchor, paddingLeft: 16, centerY: centerYAnchor, width: 6, height: 6)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: indicatorView.rightAnchor, paddingLeft: 20, centerY: centerYAnchor)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc func presentLocationInputView() {
        delegate?.presentLocationInputView()
    }
}
