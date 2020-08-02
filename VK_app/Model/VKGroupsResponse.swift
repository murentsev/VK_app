//
//  VKGroupsResponse.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class VKGroupsResponse: Decodable {
    var response: VGroupsResponse?
}

class VGroupsResponse: Decodable {
    var items: [VKGroup]
}
