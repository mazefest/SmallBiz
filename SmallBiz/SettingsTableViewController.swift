//
//  SettingsTableViewController.swift
//  SmallBiz
//
//  Created by Colby Mehmen on 5/3/23.
//

import UIKit

protocol SettingChangedDelegate: AnyObject {
    func settingToggled(item: SettingsItem)
}

class SettingsTableViewController: UITableViewController {
    lazy var datasource: [SettingsItem] = {
        var item = SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch)
        item.readDefaults()
        var item2 = SettingsItem(settingTitle: "Defaults", isActive: false, type: .disclousre)
        return [item, item2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setting = datasource[indexPath.row]
        switch setting.type {
        case .toggleSwitch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallBizUitl.settingsCellIdentifier, for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.item = setting
            cell.delegate = self
            cell.titleLabel.text = setting.settingTitle
            cell.settingsSwitch.isOn = setting.isActive
            return cell
            
        case .disclousre:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallBizUitl.disclosureCellIdentifier, for: indexPath) as? DisclosureTableViewCell else {
                return UITableViewCell()
            }
            cell.cellLabel.text = setting.settingTitle
            return cell
            
        }
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


extension SettingsTableViewController: SettingChangedDelegate {
    func settingToggled(item: SettingsItem) {
        UserDefaults.standard.set(!item.isActive, forKey: item.settingTitle)
    }
}
