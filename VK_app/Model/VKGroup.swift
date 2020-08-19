//
//  VKGroup.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import RealmSwift
import Firebase

class VKGroup: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo_200: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class FirebaseVKGroup {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int
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
