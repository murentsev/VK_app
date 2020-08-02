//
//  VKUsersResponse.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class VKUsersResponse: Decodable {
    var response: VUsersResponse?
}

class VUsersResponse: Decodable {
    var items: [VKUser]
}
