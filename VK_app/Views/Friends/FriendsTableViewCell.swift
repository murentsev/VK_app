//
//  FriendsTableViewCell.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var friendCity: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarView.addGestureRecognizer(tap)
    }
    
    @objc func avatarTapped(_ recognizer: UITapGestureRecognizer) {
        avatarView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: [], animations: {
            self.avatarView.transform = .identity
        }, completion: {_ in
            
        })
    }
}
