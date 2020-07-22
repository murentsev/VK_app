//
//  FullScreenPhotoViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 21.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {

    var photos: [UIImage] = []
    var photo: UIImage? = nil
    var index = 0
    var currentDirection: Direction? = nil
    var animator: UIViewPropertyAnimator!
    
    enum Direction {
        case left, right
        
        init(x: CGFloat) {
            self = x > 0 ? .right : .left
        }
    }
    
    @IBOutlet weak var currentPhoto: UIImageView!
    lazy var nextPhoto = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPhoto.contentMode = .scaleAspectFit
       
        currentPhoto.image = photos[index]
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(pan)
    }
    
    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        guard let panView = sender.view else { return }
        let translation = sender.translation(in: panView)
        let direction = Direction(x: translation.x)
        if currentDirection == nil {
            currentDirection = direction
            print(#function)
            print(currentDirection!)
            print(direction)
        }
        switch sender.state {
        case .began:
            
            animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn, animations: {
                self.currentPhoto.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.currentPhoto.alpha = 0
            })
           
            if canSlide(direction) {
                let nextIndex = direction == .left ? index + 1 : index - 1
                nextPhoto.image = photos[nextIndex]
                view.addSubview(nextPhoto)
                let offsetX = direction == .left ? view.bounds.width : -view.bounds.width
                nextPhoto.frame = view.bounds.offsetBy(dx: offsetX, dy: 0)
                
                animator.addAnimations({
                    self.nextPhoto.center = self.currentPhoto.center
                    self.nextPhoto.alpha = 1
                }, delayFactor: 0.15)
            }
            
            animator.addCompletion { (position) in
                guard position == .end else { return }
                self.index = direction == .left ? self.index + 1 : self.index - 1
                self.currentPhoto.alpha = 1
                self.currentPhoto.transform = .identity
                self.currentPhoto.image = self.photos[self.index]
                self.nextPhoto.removeFromSuperview()
            }
            animator.pauseAnimation()
        case .changed:
            print("---")
            print(direction)
            print(currentDirection!)
            if direction == currentDirection! {
            animator.fractionComplete = abs(translation.x) / panView.frame.width
            }
        case .ended:
            if direction == currentDirection! {
            if canSlide(direction), animator.fractionComplete > 0.4 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                currentDirection = nil
            } else {
                animator.stopAnimation(true)
                UIView.animate(withDuration: 0.25) {
                    self.currentPhoto.transform = .identity
                    self.currentPhoto.alpha = 1
                    let offsetX = direction == .left ? self.view.bounds.width : -self.view.bounds.width
                    self.nextPhoto.frame = self.view.bounds.offsetBy(dx: offsetX, dy: 0)
                }
                currentDirection = nil
            }
            } else {
                animator.stopAnimation(true)
                currentDirection = nil
            }
        default:
            print(#function)
        }
    }
    
    func canSlide(_ direction: Direction) -> Bool {
        if direction == .left {
            return index < photos.count - 1
        } else {
            return index > 0
        }
    }
    


}
