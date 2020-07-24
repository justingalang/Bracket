//
//  CreationTableViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/21/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import iOSDropDown

class CreationTableViewController: UITableViewController, UITextFieldDelegate{
	
	
	var allCellsText = [String]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		Defaults.creationTournamentSize = 2
		NotificationCenter.default.addObserver(self, selector: #selector(updateOptionSize), name: NSNotification.Name(rawValue: "didTapOnIncreaseSize"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateOptionSize), name: NSNotification.Name(rawValue: "didTapOnDecreaseSize"), object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(updateSetOptions), name: NSNotification.Name(rawValue: "didPressNext"), object: nil)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 120.0
    }
	
	@objc func updateOptionSize(){
		tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 {
			return 1
		}
		
		return (Defaults.creationTournamentSize ?? 2)/2
	}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CreationTournamentSizeTableViewCell.identifier, for: indexPath) as! CreationTournamentSizeTableViewCell
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: CreationOptionTableViewCell.identifier, for: indexPath) as! CreationOptionTableViewCell
		cell.optionOneTextField.delegate = self
		cell.optionTwoTextField.delegate = self
		cell.optionOneTextField.text = "Test1"
		cell.optionTwoTextField.text = "Test2"

		return cell
    }
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		allCellsText.append(textField.text!)
        print(allCellsText)
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
