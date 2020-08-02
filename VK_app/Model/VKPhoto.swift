//
//  VKPhoto.swift
//  VK_app
//
//  Created by Алексей Муренцев on 01.08.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class VKPhoto: Decodable {
    var id: Int
    var sizes: [PhotoSize]
}

struct PhotoSize: Decodable {
    var type: String
    var url: String
    var width: Int
    var height: Int
}
