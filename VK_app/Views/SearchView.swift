//
//  SearchView.swift
//  VK_app
//
//  Created by Алексей Муренцев on 12.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class SearchView: UIView, UITextFieldDelegate {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .none
        textField.delegate = self
        
        return textField
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        cancelButton.tintColor = .black
        //cancelButton.isHidden = true
        //cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return cancelButton
    }()
    
    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView()
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = .black
        return searchIcon
    }()
    
    var iconCenterXConstraint: NSLayoutConstraint!
    var textFieldLeftConstraint: NSLayoutConstraint!
    var cancelButtonLeftConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
      //  backgroundColor = .purple
        addSubview(textField)
        addSubview(cancelButton)
        addSubview(searchIcon)
        
       iconCenterXConstraint = searchIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
       textFieldLeftConstraint = textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
       cancelButtonLeftConstraint = cancelButton.leftAnchor.constraint(equalTo: rightAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            textFieldLeftConstraint,
            textField.rightAnchor.constraint(equalTo: cancelButton.leftAnchor, constant: 0),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 70),
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            cancelButtonLeftConstraint,
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            iconCenterXConstraint
        ])
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        iconCenterXConstraint.constant = -(bounds.width / 2 - searchIcon.bounds.width)
        textFieldLeftConstraint.constant = searchIcon.bounds.width + 20
        cancelButtonLeftConstraint.constant = -(cancelButton.bounds.width - 10)
        
        UIView.animate(withDuration: 0.5) {
           //self.layoutIfNeeded()
            self.textField.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray5])
           // self.cancelButton.isHidden = false
            
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            self.layoutIfNeeded()
        }, completion: {_ in
            
        })
        return true
    }
    
    @objc func cancelTapped() {
        iconCenterXConstraint.constant = 0
               textFieldLeftConstraint.constant = 10
               cancelButtonLeftConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            self.textField.resignFirstResponder()
            self.textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray5])
            self.layoutIfNeeded()
        }, completion: {_ in
            
        })
    }
}
