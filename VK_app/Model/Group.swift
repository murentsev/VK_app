//
//  Group.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.image == rhs.image && lhs.name == rhs.name
    }
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
