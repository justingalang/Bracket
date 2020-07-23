//
//  CreationTournamentSizeTableViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/21/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class CreationTournamentSizeTableViewCell: UITableViewCell {

	@IBOutlet weak var increaseSizeButton: UIButton!
	@IBOutlet weak var decreaseSizeButton: UIButton!
	
	static let identifier = "CreationTournamentSizeTableViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()
		configureButtons()
        // Initialization code
    }
	
	func configureButtons() {
		self.increaseSizeButton.setTitle("\((Defaults.creationTournamentSize ?? 0)*2)", for: .normal)
		self.increaseSizeButton.setTitle("\((Defaults.creationTournamentSize ?? 0))", for: .disabled)
		self.decreaseSizeButton.setTitle("\((Defaults.creationTournamentSize ?? 0)/2)", for: .normal)
		self.decreaseSizeButton.setTitle("\((Defaults.creationTournamentSize ?? 0))", for: .disabled)
		if (Defaults.creationTournamentSize ?? 0)*2 == 128 || (Defaults.creationTournamentSize ?? 0)*2 == 0 {
			increaseSizeButton.isEnabled = false
		} else if (Defaults.creationTournamentSize ?? 0)/2 == 1 {
			decreaseSizeButton.isEnabled = false
		} else {
			increaseSizeButton.isEnabled = true
			decreaseSizeButton.isEnabled = true
		}
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@IBAction func didTapOnIncreaseSize(_ sender: Any) {
		let optionCount = Defaults.creationTournamentSize
		Defaults.creationTournamentSize = (optionCount ?? 2)*2
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didTapOnIncreaseSize"), object: nil)
		configureButtons()
	}
	
	@IBAction func didTapOnDecreaseSize(_ sender: Any) {
		let optionCount = Defaults.creationTournamentSize
		Defaults.creationTournamentSize = (optionCount ?? 2)/2
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didTapOnDecreaseSize"), object: nil)
		configureButtons()
	}
	
	
	
	

}
