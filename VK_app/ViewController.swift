//
//  ViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 14.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    @IBAction func scrollTapped(_ gesture: UIGestureRecognizer) {
          scrollView.endEditing(true)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        signInButton.layer.cornerRadius = 10
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
    
  
    @IBAction func loading(_ sender: Any) {
        
        
        let isValid = checkUserData()
        if !isValid {
            showErrorAlert()
        } else {
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            view.addSubview(backgroundView)
            backgroundView.frame = view.bounds
            
            let loadingView = LoadingView()
            backgroundView.addSubview(loadingView)
            loadingView.center = view.center
            loadingView.startAnimation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                backgroundView.removeFromSuperview()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "main")
                tabBarViewController.modalPresentationStyle = .fullScreen
                self.present(tabBarViewController, animated: true, completion: nil)
            }
            
            
            
        }
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//          if identifier == "Home" {
//             let isValid = checkUserData()
//              if !isValid {
//                  showErrorAlert()
//              }
//              return isValid
//          }
//          return true
//      }
      
      func checkUserData() -> Bool {
          return loginTextField.text == "admin" &&
          passwordTextField.text == "admin"
      }
      
      func showErrorAlert() {
          let alert = UIAlertController(
              title: "Ошибка",
              message: "Неправильный логин или пароль",
              preferredStyle: .alert
          )
          let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
      }
}

