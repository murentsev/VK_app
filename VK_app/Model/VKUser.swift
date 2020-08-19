//
//  VKUser.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import RealmSwift
import Firebase

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
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class VKCity: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var title: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class FirebaseVKUser {
    let id: String
    var groups: [FirebaseVKGroup]?
    
    init(id: String) {
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String
            else {
                return nil
        }
        self.id = id
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id" : id
        ]
    }
}


