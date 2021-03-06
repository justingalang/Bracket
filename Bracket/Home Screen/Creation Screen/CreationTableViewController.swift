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
	
	var options = Array(repeating:
	String(), count: (Defaults.creationTournamentSize ?? 2))
	var currentRow = Int()
	private let viewModel = OptionListViewModel()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		Defaults.creationTournamentSize = 2
	
		NotificationCenter.default.addObserver(self, selector: #selector(updateSetOptions), name: NSNotification.Name(rawValue: "didPressNext"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateOptionSize), name: NSNotification.Name(rawValue: "didTapOnIncreaseSize"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateOptionSize), name: NSNotification.Name(rawValue: "didTapOnDecreaseSize"), object: nil)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 120.0
    }
	
	@objc func updateOptionSize(){
		var newOptions = Array(repeating:
		String(), count: (Defaults.creationTournamentSize ?? 2))
		for (index, option) in options.enumerated() {
			if index < newOptions.count {
				newOptions[index] = option
			}
		}
		options = newOptions
		tableView.reloadData()
		
	}
	
	@objc func updateSetOptions() {
		Defaults.creationTournamentOptionsArray = options
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
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
		cell.optionOneTextField.text = options[2*indexPath.row]
		cell.optionTwoTextField.text = options[2*indexPath.row + 1]
		cell.optionOneTextField.tag = 2*indexPath.row + 1
		cell.optionTwoTextField.tag = 2*indexPath.row + 2
		cell.optionOneTextField.delegate = self
		cell.optionTwoTextField.delegate = self
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func textFieldDidChangeSelection(_ textField: UITextField) {
		options[textField.tag - 1] = textField.text ?? ""
	}
	
	
//******************************************************************
//***************** SECTION HEADER *********************************
//	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		if section == 0 { return 50 }
//		return 0
//    }
//
//	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		if section == 0 {
//			let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//			headerView.backgroundColor = UIColor.white
//
//			let label = UILabel()
//			label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//			label.text = "Round One"
//			label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.regular)
//			label.textColor = UIColor.black
//
//			headerView.addSubview(label)
//
//			return headerView
//		}
//
//		return nil
//    }
//********************************************************************
    
   
	
}
