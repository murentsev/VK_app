//
//  AnimationContoller.swift
//  VK_app
//
//  Created by Алексей Муренцев on 26.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 1
    
    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        
        toView.frame = toFrameStart
        
        toView.transform = toIndex > fromIndex ? CGAffineTransform(rotationAngle: -90.0) : CGAffineTransform(rotationAngle: 90.0)
        toView.frame.origin.y = -fromView.frame.height + fromView.frame.width
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                toView.transform = CGAffineTransform(rotationAngle: 0)
                fromView.frame = fromFrameEnd
                toView.frame = frame
                fromView.transform = toIndex > fromIndex ? CGAffineTransform(rotationAngle: 90.0) : CGAffineTransform(rotationAngle: -90.0)
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
    //    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    //        return 0.6
    //    }
    //
    //    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    //        let containerView = transitionContext.containerView
    //        guard let fromView = transitionContext.viewController(forKey: .from) else { return }
    //        guard let toView = transitionContext.viewController(forKey: .to) else { return }
    //        let containerViewFrame = containerView.frame
    //        let fromViewTargetFrame = CGRect(
    //                                            x: 0,
    //                                            y: -containerViewFrame.height,
    //                                            width: fromView.view.frame.width,
    //                                            height: fromView.view.frame.height
    //                                        )
    //        let toViewTargetFrame = fromView.view.frame
    //        containerView.addSubview(toView.view)
    //        toView.view.frame = CGRect(
    //                                    x: 0,
    //                                    y: containerViewFrame.height,
    //                                    width: fromView.view.frame.width,
    //                                    height: fromView.view.frame.height
    //                                )
    //
    //
    //        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
    //            fromView.view.frame = fromViewTargetFrame
    //            toView.view.frame = toViewTargetFrame
    //        }) { finished in
    //            fromView.removeFromParent()
    //            transitionContext.completeTransition(finished)
    //        }
    //        //
    //        //        transitionContext.containerView.addSubview(toView.view)
    //        //        toView.view.frame = fromView.view.frame
    //        //        toView.view.transform = CGAffineTransform(rotationAngle: 90)
    //        //        toView.view.transform = CGAffineTransform(translationX: fromView.view.frame.width, y: 0)
    //
    //
    //    }
    
    
}
