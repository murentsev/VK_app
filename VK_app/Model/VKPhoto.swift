//
//  VKPhoto.swift
//  VK_app
//
//  Created by Алексей Муренцев on 01.08.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import RealmSwift

class VKPhoto: Object, Decodable {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    var sizes = List<PhotoSize>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sizes = "sizes"
    }
}

class PhotoSize: Object, Decodable {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

//class VKPhotoRealm: Object {
//    
//    @objc dynamic var id: Int = 0
//    var sizes = List<PhotoSize>()
//    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//    
//}
