//
//  User.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class User {
    
   // var login: String
   // var password: String
    
    var name: String
    var image: String
    var city: String
    var images: [String]
 //   var userGroups: [Group]?
    
    init(
        name: String,
        image: String,
        city: String,
        images: [String]
        //,userGroups: [Group]
    ) {
        self.name = name
        self.image = image
        self.city = city
        self.images = images
       // self.userGroups = userGroups
    }
    
}
