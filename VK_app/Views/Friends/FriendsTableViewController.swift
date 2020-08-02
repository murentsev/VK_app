//
//  FriendsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsTableViewController: UITableViewController, UISearchBarDelegate, searchViewDelegate {
 
    lazy var service = VKService()
    
    @IBOutlet weak var Search: SearchView!
    var filteredFriends: [VKUser] = []
    var friends: [VKUser] = []
    
    var sections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Search.delegate = self
        service.getData(.friends) {[weak self] friendsAnyArr in
            let friendsArr = friendsAnyArr as! [VKUser]
            self?.friends = friendsArr.sorted(by: {$0.name < $1.name})
            self?.tableView.setContentOffset(CGPoint.init(x: 0, y: -20), animated: false)
            self?.filteredFriends = friendsArr.sorted(by: {$0.name < $1.name})
            self?.sections = Array(Set((self?.filteredFriends.map ({ $0.name.prefix(1).uppercased() }))!)).sorted()
            self?.tableView.reloadData()
        }
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
        // #warning Incomplete implementation, return the number of rows
        return itemsInSection(section).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendsTableViewCell
      //  cell.textLabel?.text = itemsInSection(indexPath.section)[indexPath.row].name
        cell.friendName.text = itemsInSection(indexPath.section)[indexPath.row].name
        if let imgUrl = URL(string: itemsInSection(indexPath.section)[indexPath.row].photo_200_orig) {
            let imgResource = ImageResource(downloadURL: imgUrl)
            cell.avatarView.imageView.kf.setImage(with: imgResource)
        }
            
            
        cell.friendCity.text = itemsInSection(indexPath.section)[indexPath.row].city?.title
        
      //  cell.makeRounded()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoCollectionViewController {
            //let index = tableView.indexPathForSelectedRow!.section * tableView.indexPathForSelectedRow!.row
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
        filteredFriends = friends
        if !searchText.isEmpty {
            filteredFriends = friends.filter({ $0.name.contains(searchText) })
        }
        tableView.reloadData()
    }
    
    func searchFriends(searchText: String) {
        filteredFriends = friends
        if !searchText.isEmpty {
            filteredFriends = filteredFriends.filter({ $0.name.contains(searchText) })
        }
        tableView.reloadData()
    }
    
    func clearSearchFriends() {
        filteredFriends = friends
        tableView.reloadData()
    }
    
    
    
   
}

