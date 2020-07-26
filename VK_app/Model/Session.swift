//
//  Session.swift
//  VK_app
//
//  Created by Алексей Муренцев on 26.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation

class Session {
    
    static let instance = Session()
    private init() {}
    
    var token: String = ""
    var userId: Int = 0
    
    
}
