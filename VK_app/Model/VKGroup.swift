//
//  VKGroup.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import RealmSwift

class VKGroup: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var photo_200: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
