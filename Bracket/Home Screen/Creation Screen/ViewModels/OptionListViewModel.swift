//
//  OptionListViewModel.swift
//  Bracket
//
//  Created by Justin Galang on 7/24/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import UIKit

class OptionListViewModel: UITableViewController {
	
	public var didNotificationReceived: (() -> Void)?
	
	var notifictions: [OptionViewModel]? {
		didSet {
			didNotificationReceived?()
		}
	}
	
	
	private var cellModels = Array(repeating:
	OptionViewModel(), count: (Defaults.creationTournamentSize ?? 2))
	
	var rawData: [String] {
		cellModels.map{ $0.text }
	}
	
	@objc func updateOptionSize(){
		updateCellModelSize()
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
	}
	
	func updateCellModelSize() {
		self.cellModels = Array(repeating:
		OptionViewModel(), count: (Defaults.creationTournamentSize ?? 2))
	}
	
	//Tableview STuff
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 1 {
			return 1
		}
		return cellModels.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CreationTournamentSizeTableViewCell.identifier, for: indexPath) as! CreationTournamentSizeTableViewCell
			return cell
		}
		
		guard let cell = tableView.dequeCreationOptionTableViewCell(for: indexPath) else {
			print("Ooops.")
			return UITableViewCell()
		}
		print("CELL INDEX \(cellModels[indexPath.row])")
		let model = cellModels[indexPath.row]
		cell.load(viewModel: model)
		return cell
	}
}

private extension UITableView {
	func dequeCreationOptionTableViewCell(for indexPath: IndexPath) -> CreationOptionTableViewCell? {
			dequeueReusableCell(withIdentifier: CreationOptionTableViewCell.identifier, for: indexPath) as? CreationOptionTableViewCell
	}
}

