//
//  NewsTableViewCell.swift
//  VK_app
//
//  Created by Алексей Муренцев on 07.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var mainImage: AvatarView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
   // @IBOutlet weak var collectionView: UICollectionView!
    
    
    func configure(model: NewsModel) {
        mainImage.avatarImage = model.images?.first
        authorLabel.text = model.author
        dateLabel.text = model.postDate
        newsTextLabel.text = model.text
        
//        collectionView.register(UINib(nibName: "PhotoNewsCollectionViewCell", bundle: nil),
//                                forCellWithReuseIdentifier: "cell")
    }
    
//    func setCollectionDelegate(_ delegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
//        collectionView.dataSource = delegate
//        collectionView.delegate = delegate
//        collectionView.tag = row
//        collectionView.reloadData()
//    }
    
    
}
