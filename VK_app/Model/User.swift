//
//  User.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class User {
    
   // var login: String
   // var password: String
    
    var name: String
    var image: UIImage
    var city: String
    var images: [UIImage]
 //   var userGroups: [Group]?
    
    init(
        name: String,
        image: UIImage,
        city: String,
        images: [UIImage]
        //,userGroups: [Group]
    ) {
        self.name = name
        self.image = image
        self.city = city
        self.images = images
       // self.userGroups = userGroups
    }
    
    static var fakePhotoArray: [UIImage] = (1...50).map {_ in
        Lorem.avatar
    }
    
    static var fake: [User] = (1...56).map {_ in
        User(
            name: Lorem.fullName,
            image: Lorem.avatar,
            city: Lorem.word,
            images: User.fakePhotoArray
            )
      }
}
