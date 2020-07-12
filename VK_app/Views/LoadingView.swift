//
//  LoadingView.swift
//  VK_app
//
//  Created by Алексей Муренцев on 11.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    var dotsCount: Int = 3
    var dotHeight: CGFloat = 20
    var animationDuration: TimeInterval = 1
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    var dotViews: [UIView] = []
    
    func createDotView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: dotHeight)
        ])
        
        (1...dotsCount).forEach { _ in
            let dot = createDotView()
            stackView.addArrangedSubview(dot)
            NSLayoutConstraint.activate([
                dot.heightAnchor.constraint(equalToConstant: dotHeight),
                dot.widthAnchor.constraint(equalToConstant: dotHeight)
            ])
            dot.layer.cornerRadius = dotHeight / 2
            dotViews.append(dot)
        }
    }
    
    func startAnimation() {
        let step = animationDuration / Double(dotsCount)
        (0...dotsCount - 1).forEach{
            let dot = dotViews[$0]
            UIView.animate(withDuration: animationDuration, delay: step * Double($0), options: [.repeat], animations: {
                dot.alpha = 0
            }, completion: nil)
        }
    }
    
    func stopAnimation() {
        
    }
    
}
