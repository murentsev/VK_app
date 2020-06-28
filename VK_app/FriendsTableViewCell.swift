//
//  FriendsTableViewCell.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var friendCity: UILabel!
    
//    func makeRounded() {
//      
//        
//        
//        
//        
//        let shadowView = UIView(frame: friendImage.bounds)
//        
//        shadowView.clipsToBounds = false
//        //friendImage.layer.masksToBounds = false
//        shadowView.layer.shadowRadius = friendImage.frame.height/2
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOpacity = 1
//        shadowView.layer.shadowOffset = .zero
//        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 10).cgPath
//        // friendImage.layer.shouldRasterize = true
//        //friendImage.layer.masksToBounds = false
//        
//        
//        friendImage.clipsToBounds = true
//        friendImage.layer.cornerRadius = friendImage.frame.height/2
//        
//        friendImage.addSubview(shadowView)
//        
//        
//    }

}
