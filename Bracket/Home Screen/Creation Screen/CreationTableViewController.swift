//
//  CreationTableViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/21/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class CreationTableViewController: UITableViewController{
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		Defaults.creationNumberOfOptions = 2
		NotificationCenter.default.addObserver(self, selector: #selector(updateOptionSize), name: NSNotification.Name(rawValue: "didTapOnUpdateSize"), object: nil)
		
    }
	
	@objc func updateOptionSize(){
		tableView.reloadData()
	}
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of
        return 3
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Title"
		} else if section == 1 {
			return "Options"
		}
		return nil
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		<#code#>
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else if section == 2 {
			return 1
		}
		
		return (Defaults.creationNumberOfOptions ?? 2)/2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CreationTitleTableViewCell.identifier, for: indexPath) as! CreationTitleTableViewCell
			return cell
		} else if indexPath.section == 2 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CreationTournamentSizeTableViewCell.identifier, for: indexPath) as! CreationTournamentSizeTableViewCell
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: CreationOptionTableViewCell.identifier, for: indexPath) as! CreationOptionTableViewCell
		return cell
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}


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
