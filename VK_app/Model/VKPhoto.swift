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
    @objc dynamic var id: Int
    var sizes: [PhotoSize]
}

class PhotoSize: Object, Decodable {
    @objc dynamic var type: String
    @objc dynamic var url: String
    @objc dynamic var width: Int
    @objc dynamic var height: Int
}
