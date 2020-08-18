//
//  GroupsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    lazy var service = VKService()
    lazy var realm = try! Realm()
    var notificationToken: NotificationToken?
    var groupsResult: Results<VKGroup>!
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        //        guard
        //            let globalGroupsController = segue.source as? GlobalGroupsTableViewController,
        //            let indexPath = globalGroupsController.tableView.indexPathForSelectedRow
        //            else { return }
        //        let group = globalGroupsController.globalGroups[indexPath.row]
        //        guard !groups.contains(group) else { return }
        //        groups.append(group)
        //        tableView.reloadData()
    }
    
    var filteredGroups: [VKGroup] = []
    var groups: [VKGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToNotifications()
        LoadFromNetwork()
        tableView.setContentOffset(CGPoint.init(x: 0, y: 44), animated: false)
    }
    
    func LoadFromNetwork() {
        service.getData(.groups, type: VKGroup.self)
    }
    
    private func subscribeToNotifications() {
        groupsResult = realm.objects(VKGroup.self)
        notificationToken = groupsResult.observe {[weak self] (changes) in
            switch changes {
            case .initial(let groupsResult):
                self?.filteredGroups = Array(groupsResult)
                self?.tableView.reloadData()
            case .update(let groupsResult, _, _, _):
                self?.filteredGroups = Array(groupsResult)
                self?.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupName.text = filteredGroups[indexPath.row].name
        if let imgUrl = URL(string: filteredGroups[indexPath.row].photo_200) {
            let imgResource = ImageResource(downloadURL: imgUrl)
            cell.groupImage.kf.setImage(with: imgResource)
            cell.groupImage.contentMode = .scaleAspectFill
        }
        cell.makeRounded()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = Array(groupsResult)
        if !searchText.isEmpty {
            filteredGroups = filteredGroups.filter({ $0.name.contains(searchText) })
        }
        tableView.reloadData()
    }
    
}
