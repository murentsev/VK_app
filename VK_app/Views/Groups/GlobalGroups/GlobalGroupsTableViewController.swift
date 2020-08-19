//
//  GlobalGroupsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class GlobalGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var service = VKService()
    
    lazy var database = Database.database()
    lazy var ref: DatabaseReference = self.database.reference(withPath: "users")
    
    var filteredGlobalGroups: [VKGroup] = []
    
    var globalGroups: [VKGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getData(.groupSearch, type: VKGroup.self) {[weak self] (groupsAnyArr: [VKGroup]) in
               
                   self?.globalGroups = groupsAnyArr
                   self?.filteredGlobalGroups = groupsAnyArr
                   self?.tableView.reloadData()
               }
        filteredGlobalGroups = globalGroups
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGlobalGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GlobalGroupsTableViewCell
        if let imgUrl = URL(string: filteredGlobalGroups[indexPath.row].photo_200) {
            let imgResource = ImageResource(downloadURL: imgUrl)
            cell.globalGroupImage.kf.setImage(with: imgResource)
            cell.globalGroupImage.contentMode = .scaleAspectFill
        }
        cell.globalGroupName.text = filteredGlobalGroups[indexPath.row].name
        cell.makeRounded()
        
        return cell
    }
    

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
          UIView.animate(withDuration: 0.3) {
              self.view.layoutIfNeeded()
          }
      }
      
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGlobalGroups = globalGroups
        if !searchText.isEmpty {
            service.getData(.groupSearch, groupSearch: searchText, type: VKGroup.self) {[weak self] (groupsArr: [VKGroup]) in
                //let groupsArr = groupsAnyArr as! [VKGroup]
                self?.globalGroups = groupsArr
                self?.filteredGlobalGroups = groupsArr
                self?.tableView.reloadData()
            }
        } else {
            service.getData(.groupSearch, type: VKGroup.self) {[weak self] (groupsArr: [VKGroup]) in
                self?.globalGroups = groupsArr
                self?.filteredGlobalGroups = groupsArr
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupId = filteredGlobalGroups[indexPath.row].id
        let groupName = filteredGlobalGroups[indexPath.row].name
        service.getData(.addGroup, id: groupId, type: VKGroup.self)
        addUserToFirebase(Session.instance.userId, groupId, groupName)
    }

    func addUserToFirebase(_ userId: String, _ groupId: Int, _ groupName: String) {
        let group = FirebaseVKGroup(id: groupId)
        ref.child(Session.instance.userId).child("groups").child(groupName).setValue(group.toDictionary())
//        let group = FirebaseVKGroup(id: groupId)
//        ref.child(userId).setValue(user.toDictionary())
    }
}
