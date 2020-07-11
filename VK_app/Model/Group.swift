//
//  Group.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.image == rhs.image && lhs.name == rhs.name
    }
    
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    static var fake: [Group] = (1...23).map {_ in
        Group(name: Lorem.words(2), image: Lorem.avatar)
    }
}
