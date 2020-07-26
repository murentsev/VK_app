//
//  TabViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 26.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
//        tabBar.backgroundColor = .white
//        tabBar.barTintColor = .white
        delegate = self
        // Do any additional setup after loading the view.
    }
}

extension TabViewController: UITabBarControllerDelegate  {
  
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(viewControllers: tabBarController.viewControllers)
      }
}
