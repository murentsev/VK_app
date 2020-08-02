//
//  VKAuthViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 28.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VKAuthViewController: UIViewController, WKNavigationDelegate {
    
 
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVKAuth()
    }
    
    
    func loadVKAuth() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7551511"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
            
        ]
        guard let url = components.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
            else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"] else { return }
        
        Session.instance.token = token
        
        performSegue(withIdentifier: "Home", sender: nil)
//        getData(token: token, method: vkMethods.friends)
//        getData(token: token, method: vkMethods.photos)
//        getData(token: token, method: vkMethods.groups)
//        getData(token: token, method: vkMethods.groupSearch, groupSearch: "Типичный воронеж")
        
        decisionHandler(.cancel)
    }
    
    
    
   
    
}
