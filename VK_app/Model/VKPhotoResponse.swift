//
//  VKPhotoResponse.swift
//  VK_app
//
//  Created by Алексей Муренцев on 01.08.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class VKPhotoResponse: Decodable {
    var response: VPhotoResponse?
}

class VPhotoResponse: Decodable {
    var items: [VKPhoto]
}
