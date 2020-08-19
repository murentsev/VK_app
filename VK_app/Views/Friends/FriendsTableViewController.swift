//
//  FriendsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift


class FriendsTableViewController: UITableViewController, UISearchBarDelegate, searchViewDelegate {
 
    lazy var service = VKService()
    lazy var realm = try! Realm()
    
    var notificationToken: NotificationToken?
    var friendsResult: Results<VKUser>!
    
    @IBOutlet weak var Search: SearchView!
    var filteredFriends: [VKUser] = [] {
        didSet {
            sections = Array(Set(filteredFriends
                .map { $0.name.prefix(1).uppercased() }
                )).sorted()
        }
    }
   // var friends: [VKUser] = []
    
    
    var sections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Search.delegate = self
        subscribeToNotifications()
        LoadFromNetwork()
    }
        
    private func subscribeToNotifications() {
        friendsResult = realm.objects(VKUser.self)
        notificationToken = friendsResult.observe {[weak self] (changes) in
            switch changes {
            case .initial(let friendsResult):
                self?.filteredFriends = Array(friendsResult)
                self?.tableView.reloadData()
            case .update(let friendsResult, _, _, _):
                self?.filteredFriends = Array(friendsResult)
                self?.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }
    
    func LoadFromNetwork() {
        service.getData(.friends, type: VKUser.self)
        //tableView.setContentOffset(CGPoint.init(x: 0, y: -20), animated: false)
    }

    // MARK: - Table view data source
    
    func itemsInSection(_ section: Int) -> [VKUser] {
        let letter = sections[section]
        
        return filteredFriends.filter { $0.name.hasPrefix(letter) }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSection(section).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendsTableViewCell
        cell.friendName.text = itemsInSection(indexPath.section)[indexPath.row].name
        if let imgUrl = URL(string: itemsInSection(indexPath.section)[indexPath.row].photo_200_orig) {
            let imgResource = ImageResource(downloadURL: imgUrl)
            cell.avatarView.imageView.kf.setImage(with: imgResource)
        }
        cell.friendCity.text = itemsInSection(indexPath.section)[indexPath.row].city?.title

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoCollectionViewController {
            controller.id = itemsInSection(tableView.indexPathForSelectedRow!.section)[tableView.indexPathForSelectedRow!.row].id
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if itemsInSection(section).isEmpty {
            return nil
        }
        return sections[section]
    }
   
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriends = Array(friendsResult)
        if !searchText.isEmpty {
            filteredFriends = filteredFriends.filter({ $0.name.contains(searchText) })
        }
        tableView.reloadData()
    }

    func searchFriends(searchText: String) {
        filteredFriends = Array(friendsResult)
        if !searchText.isEmpty {
            filteredFriends = filteredFriends.filter({ $0.name.contains(searchText) })
        }
        tableView.reloadData()
    }

    func clearSearchFriends() {
        filteredFriends = Array(friendsResult)
        tableView.reloadData()
    }
   
}

