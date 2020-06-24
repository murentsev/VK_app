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
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendCity: UILabel!
    
    func makeRounded() {
       // friendImage.layer.borderWidth = 1
        friendImage.layer.masksToBounds = false
        //friendImage.layer.borderColor = UIColor.black.cgColor
        friendImage.layer.cornerRadius = friendImage.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        friendImage.clipsToBounds = true
    }

}
