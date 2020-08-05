//
//  VKUser.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import RealmSwift

final class VKUser: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var first_name: String
    @objc dynamic var last_name: String
    @objc dynamic var photo_200_orig: String
    @objc dynamic var online: Int
    @objc dynamic var city: VKCity?
    var name: String {
        first_name + " " + last_name
    }
//    var images: [VKPhoto] {
//        
//    }
}

final class VKCity: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var title: String
}
