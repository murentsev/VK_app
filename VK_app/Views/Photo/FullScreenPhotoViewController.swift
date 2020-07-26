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
    
    var transitionController: TransitionController? {
        return transitioningDelegate as? TransitionController
    }
    
    enum Direction {
        case left, right, down, up
        
        init(x: CGFloat, y: CGFloat) {
            if abs(x) > abs(y) {
                self = x > 0 ? .right : .left
            } else {
                self = y < 0 ? .up : .down
            }
        }
    }
    
    @IBOutlet weak var currentPhoto: UIImageView!
    lazy var nextPhoto = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPhoto.contentMode = .scaleAspectFit
        transitionController?.endView = currentPhoto
        currentPhoto.image = photos[index]
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(pan)
    }
    
    //    @objc func onPanDiss(_ sender: UIPanGestureRecognizer) {
    //        guard let panView = sender.view else { return }
    //         let translation = sender.translation(in: panView)
    //        let percent = translation.y / panView.bounds.height
    //
    //        switch sender.state {
    //        case .began:
    //
    //        case .changed:
    //
    //        case .cancelled:
    //            transitionController?.interactionController?.cancel()
    //        case .ended:
    //
    //        default:
    //            break
    //        }
    //    }
    
    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        guard let panView = sender.view else { return }
        let translation = sender.translation(in: panView)
        let direction = Direction(x: translation.x, y: translation.y)
        print("-----")
        print(direction)
        print(translation.x)
        print(translation.y)
        let percent = translation.y / panView.bounds.height
        
        //тест
        if currentDirection != nil {
            print("***")
            print(currentDirection!)
        }
        
        //определяем первоначальное направление движения
        if currentDirection == nil && direction != .up {
            currentDirection = direction
            print(#function)
            print(currentDirection!)
            print(direction)
        }
        
        
        switch sender.state {
        case .began:
            if  (direction == .left || direction == .right) && currentDirection != nil {
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
            } else if direction == .down {
                transitionController?.interactionController = UIPercentDrivenInteractiveTransition()
                dismiss(animated: true, completion: nil)
            }
        case .changed:
            print(#function)
            print("---")
            print(direction)
            print("#")
            print(currentDirection!)
            if direction == .left || direction == .right {
                
                if direction == currentDirection! {
                    animator.fractionComplete = abs(translation.x) / panView.frame.width
                }
            } else if direction == .down {
                if direction == currentDirection! {
                    transitionController?.interactionController?.update(percent)
                }
            }
        case .cancelled:
            if direction == .down && direction == currentDirection!{
                transitionController?.interactionController?.cancel() // странно работает!
                currentDirection = nil
            }
            
        case .ended:
            if direction == .left || direction == .right {
                if direction == currentDirection! {
                    if canSlide(direction), animator.fractionComplete > 0.4 {
                        animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                    } else {
                        animator.stopAnimation(true)
                        UIView.animate(withDuration: 0.25) {
                            self.currentPhoto.transform = .identity
                            self.currentPhoto.alpha = 1
                            let offsetX = direction == .left ? self.view.bounds.width : -self.view.bounds.width
                            self.nextPhoto.frame = self.view.bounds.offsetBy(dx: offsetX, dy: 0)
                        }
                    }
                    currentDirection = nil
                } else {
                    if currentDirection! == .left || currentDirection == .right {
                        animator.stopAnimation(true)
                        
                        currentDirection = nil
                    } else if currentDirection! == .down {
                        transitionController?.interactionController?.cancel() // странно работает!
                    }
                }
            } else if direction == .down {
                if direction == currentDirection! {
                    if percent > 0.5 {
                        transitionController?.interactionController?.finish()
                    } else {
                        transitionController?.interactionController?.cancel() // странно работает!
                    }
                } else {
                    animator.stopAnimation(true)
                    UIView.animate(withDuration: 0.25) {
                        self.currentPhoto.transform = .identity
                        self.currentPhoto.alpha = 1
                        let offsetX = direction == .left ? self.view.bounds.width : -self.view.bounds.width
                        self.nextPhoto.frame = self.view.bounds.offsetBy(dx: offsetX, dy: 0)
                    }
                }
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
