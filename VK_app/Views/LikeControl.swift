
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

    @IBInspectable var isCommented: Bool = false {
        didSet {
            updateComment()
        }
    }

    @IBInspectable var isShared: Bool = false {
        didSet {
            updateShare()
        }
    }

    @IBInspectable var likeCount: Int = 0 {
        didSet {
            countLikeLabel.text = "\(likeCount)"
        }
    }

    @IBInspectable var commentCount: Int = 0 {
        didSet {
            countCommenLabel.text = "\(commentCount)"
        }
    }

    @IBInspectable var shareCount: Int = 0 {
        didSet {
            countShareLabel.text = "\(shareCount)"
        }
    }

    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var countLikeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "\(0)"
        return label
    }()

    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var countCommenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "\(0)"
        return label
    }()

    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        //    button.backgroundColor = .red
        return button
    }()

    lazy var countShareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "\(0)"
        return label
    }()


    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()

    lazy var likeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
       stackView.spacing = 5
        return stackView
    }()

    lazy var commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    lazy var shareStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
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
        addSubview(mainStackView)
        mainStackView.addSubview(likeStackView)
        mainStackView.addSubview(commentStackView)
        mainStackView.addSubview(shareStackView)

        
        NSLayoutConstraint.activate([

            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),

            likeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            likeStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            likeStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),

            commentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            commentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            commentStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 80),

            shareStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            shareStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            shareStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 160),

        ])

        likeStackView.addArrangedSubview(likeButton)
        likeStackView.addArrangedSubview(countLikeLabel)
        commentStackView.addArrangedSubview(commentButton)
        commentStackView.addArrangedSubview(countCommenLabel)
        shareStackView.addArrangedSubview(shareButton)
        shareStackView.addArrangedSubview(countShareLabel)
    }

    // MARK: - Actions
    @objc func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
    }

    @objc func commentButtonTapped(_ sender: UIButton) {
        isCommented.toggle()
    }

    @objc func shareButtonTapped(_ sender: UIButton) {
        isShared.toggle()
    }

    private func updateLike() {
        let likeImageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: likeImageName), for: .normal)
        likeCount = isLiked ? likeCount + 1 : likeCount - 1
    }

    private func updateComment() {
        let commentImageName = isCommented ? "message.fill" : "message"
        commentButton.setImage(UIImage(systemName: commentImageName), for: .normal)
        commentCount = isCommented ? commentCount + 1 : commentCount - 1
    }

    private func updateShare() {
        let shareImageName = isShared ? "arrowshape.turn.up.right.fill" : "arrowshape.turn.up.right"
        shareButton.setImage(UIImage(systemName: shareImageName), for: .normal)
        shareCount = isShared ? shareCount + 1 : shareCount - 1
    }
}
