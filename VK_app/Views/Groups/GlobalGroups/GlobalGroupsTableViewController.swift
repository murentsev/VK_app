//
//  GlobalGroupsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit
import Kingfisher

class GlobalGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var service = VKService()
    
    var filteredGlobalGroups: [VKGroup] = []
    
    var globalGroups: [VKGroup] = []
//    var globalGroups: [Group] = [
//        Group(name: "MDK", image: "MDK"),
//        Group(name: "Satira bez pozitiva", image: "Satira bez pozitiva")
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getData(.groupSearch, type: VKGroup.self) {[weak self] (groupsAnyArr: [VKGroup]) in
                //   let groupsArr = groupsAnyArr as! [VKGroup]
                   self?.globalGroups = groupsAnyArr
                   self?.filteredGlobalGroups = groupsAnyArr
                   self?.tableView.reloadData()
               }
        //tableView.setContentOffset(CGPoint.init(x: 0, y: 44), animated: false)
        filteredGlobalGroups = globalGroups
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGlobalGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GlobalGroupsTableViewCell
        if let imgUrl = URL(string: filteredGlobalGroups[indexPath.row].photo_200) {
            let imgResource = ImageResource(downloadURL: imgUrl)
            cell.globalGroupImage.kf.setImage(with: imgResource)
            cell.globalGroupImage.contentMode = .scaleAspectFill
        }
        //cell.globalGroupImage.image = filteredGlobalGroups[indexPath.row].image
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
              //filteredGlobalGroups = globalGroups.filter({ $0.name.contains(searchText) })
          } else {
            service.getData(.groupSearch, type: VKGroup.self) {[weak self] (groupsArr: [VKGroup]) in
                           //let groupsArr = groupsAnyArr as! [VKGroup]
                           self?.globalGroups = groupsArr
                           self?.filteredGlobalGroups = groupsArr
                           self?.tableView.reloadData()
                       }
             
        }
        
        
          //tableView.reloadData()
      }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
