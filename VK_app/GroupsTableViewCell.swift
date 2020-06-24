//
//  GroupsTableViewCell.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupName: UILabel!
 
    func makeRounded() {
          // friendImage.layer.borderWidth = 1
           groupImage.layer.masksToBounds = false
           //friendImage.layer.borderColor = UIColor.black.cgColor
           groupImage.layer.cornerRadius = groupImage.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
           groupImage.clipsToBounds = true
       }
}
