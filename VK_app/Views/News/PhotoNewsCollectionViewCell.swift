//
//  PhotoNewsCollectionViewCell.swift
//  VK_app
//
//  Created by Алексей Муренцев on 07.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class PhotoNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countLable: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.isHidden = true
    }
    
}
