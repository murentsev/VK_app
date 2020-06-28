//
//  LikeControl.swift
//  VK_app
//
//  Created by Алексей Муренцев on 28.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIControl {
    
    @IBInspectable var isLiked: Bool = false {
        didSet {
            updateLike()
        }
    }
    
    @IBInspectable var likesCount: Int = 0 {
        didSet {
            countLabel.text = "\(likesCount)"
        }
    }
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.text = "\(0)"
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ])
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(likeButton)
    }
    
    // MARK: - Actions
    @objc func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
    }
    
    private func updateLike() {
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likesCount = isLiked ? likesCount + 1 : likesCount - 1
    }
}
