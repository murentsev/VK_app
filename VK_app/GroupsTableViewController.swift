//
//  GroupsTableViewController.swift
//  VK_app
//
//  Created by Алексей Муренцев on 24.06.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            let globalGroupsController = segue.source as? GlobalGroupsTableViewController,
            let indexPath = globalGroupsController.tableView.indexPathForSelectedRow
        else { return }
        let group = globalGroupsController.globalGroups[indexPath.row]
        guard !groups.contains(group) else { return }
        groups.append(group)
//        globalGroupsController.globalGroups.remove(at: indexPath.row)
//        globalGroupsController.tableView.deleteRows(at: [indexPath], with: .none)
        tableView.reloadData()
    }
    
    var groups: [Group] = [
           Group(name: "Typical Voronezh", image: "Typical Voronezh")
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupName.text = groups[indexPath.row].name
        cell.groupImage.image = UIImage(named: groups[indexPath.row].image)
        cell.makeRounded()
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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
