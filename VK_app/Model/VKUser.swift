//
//  VKUser.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class VKUser: Decodable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_200_orig: String
    var online: Int
    var city: VKCity?
    var name: String {
        first_name + " " + last_name
    }
//    var images: [VKPhoto] {
//        
//    }
}

class VKCity: Decodable {
    var id: Int
    var title: String
}
