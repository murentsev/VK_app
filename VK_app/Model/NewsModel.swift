//
//  NewsModel.swift
//  VK_app
//
//  Created by Алексей Муренцев on 07.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

struct NewsModel {
    var type: NewsItemType
    var author: String
    var postDate: String
    var text: String?
    var images: [UIImage]?
    var likesCount: Int
    var commentsCount: Int
    var repostsCount: Int
    var viewsCount: Int
    
    static var fake: [NewsModel] = (1...5).map {_ in
        NewsModel(
            type: NewsItemType(rawValue: Int.random(in: 0...1)) ?? .post,
            author: Lorem.fullName,
            postDate: "07.07.2020",
            text: Lorem.sentences(Int.random(in: 2...5)),
            images: (1...Int.random(in: 5...10))
                .map { $0 % 5 }
                .shuffled()
                .compactMap({ String($0) })
                .compactMap({ UIImage(named: $0) }),
            likesCount: Int.random(in: 0...100),
            commentsCount: Int.random(in: 0...100),
            repostsCount: Int.random(in: 0...100),
            viewsCount: Int.random(in: 0...100)
        )
    }
    
}

enum NewsItemType: Int {
    case post
    case photo
}
