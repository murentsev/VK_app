//
//  PhotoCollectionViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var service = VKService()
    lazy var realm = try! Realm()
    var notificationToken: NotificationToken?
    
    let transitionController = TransitionController()
    
    var photos: [VKPhoto] = []
    var id: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadFromCache()
        LoadFromNetwork()
    }
    
    func LoadFromCache() {
        let photosResult = realm.objects(VKPhoto.self).filter("userId == %@", id)
        subscribeToNotifications(photosResult)
        photos = Array(photosResult)
        collectionView.reloadData()
    }
    
    func LoadFromNetwork() {
        service.getData(.photos, id: id) { [weak self] (notUsed: [VKPhoto]) in
            self?.LoadFromCache()
            self?.collectionView.reloadData()
        }
    }
    
      private func subscribeToNotifications(_ photosResult: Results<VKPhoto>) {
            notificationToken = photosResult.observe {[weak self] (changes) in
                switch changes {
                case .initial:
                 self?.collectionView.reloadData()
                case .update:
                    self?.collectionView.reloadData()
                case let .error(error):
                    print(error)
                }
            }
        }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        if let imgUrl = URL(string: photos[indexPath.row].sizes.last?.url ?? "") {
            let imgResource = ImageResource(downloadURL: imgUrl)
            cell.photo.kf.setImage(with: imgResource)
            cell.photo.contentMode = .scaleAspectFill
        }
        return cell
    }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width / 3,
                        height: collectionView.bounds.width / 3)
      }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            print(#function)
            cell.alpha = 0
            cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard //segue.identifier == "fullScreeen",
                let destination = segue.destination as? FullScreenPhotoViewController,
                let indexPath = self.collectionView.indexPathsForSelectedItems?.first,
                let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
            else { return }
                
        destination.photos = photos
        destination.index = indexPath.row
        destination.transitioningDelegate = transitionController
        transitionController.startView = cell.photo
           
       }
}
