//
//  GlobalGroupsTableViewCell.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class GlobalGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var globalGroupImage: UIImageView!
       @IBOutlet weak var globalGroupName: UILabel!
    
       func makeRounded() {
        // friendImage.layer.borderWidth = 1
        globalGroupImage.layer.masksToBounds = false
        //friendImage.layer.borderColor = UIColor.black.cgColor
        globalGroupImage.layer.cornerRadius = globalGroupImage.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        globalGroupImage.clipsToBounds = true
        
        globalGroupImage.layer.shadowRadius = globalGroupImage.frame.height/2
        globalGroupImage.layer.shadowColor = UIColor.black.cgColor
        globalGroupImage.layer.shadowOpacity = 0.6
        globalGroupImage.layer.shadowOffset = .zero
        globalGroupImage.layer.shadowPath = UIBezierPath(rect: globalGroupImage.bounds).cgPath
        globalGroupImage.layer.shouldRasterize = true
          }

}
