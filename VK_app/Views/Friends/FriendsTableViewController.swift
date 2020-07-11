//
//  FriendsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {

   
    var filteredFriends: [User] = []
    var friends = User.fake
    
    var sections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = friends.sorted(by: {$0.name < $1.name})
        sections = Array(Set(friends.map ({ $0.name.prefix(1).uppercased() }))).sorted()
        filteredFriends = friends
        tableView.setContentOffset(CGPoint.init(x: 0, y: 44), animated: false)
    }

    // MARK: - Table view data source
    
    func itemsInSection(_ section: Int) -> [User] {
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
        cell.avatarView.avatarImage = itemsInSection(indexPath.section)[indexPath.row].image
        cell.friendCity.text = itemsInSection(indexPath.section)[indexPath.row].city
        
      //  cell.makeRounded()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoCollectionViewController {
            controller.photos = filteredFriends[tableView.indexPathForSelectedRow!.row].images
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
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriends = friends
        if !searchText.isEmpty {
            filteredFriends = friends.filter({ $0.name.contains(searchText) })
        }
        tableView.reloadData()
    }
   
}

