//
//  NewsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 07.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, UICollectionViewDataSource,
                        UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let news = NewsModel.fake
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.configure(model: news[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? NewsTableViewCell else { return }
        cell.setCollectionDelegate(self, for: indexPath.row)
    }
    
    //MARK: - Collection view data source
    
    enum Constants {
        static let maxPhotos = 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let imagesCount = news[collectionView.tag].images.count
        return imagesCount > Constants.maxPhotos ? Constants.maxPhotos : imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoNewsCollectionViewCell
        
        let newsModel = news[collectionView.tag]
        let image = news[collectionView.tag].images[indexPath.row]
        cell.photoImageView.image = image
        
        if indexPath.row == Constants.maxPhotos - 1 {
            let count = newsModel.images.count - Constants.maxPhotos
            cell.countLable.text = "+\(count)"
            cell.containerView.isHidden = count == 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2,
                      height: collectionView.bounds.height / 2)
    }
}
