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

	@IBOutlet weak var sizeButton: UIButton!
	static let identifier = "CreationTournamentSizeTableViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@IBAction func didTapOnUpdateSize(_ sender: Any) {
		let optionCount = Defaults.creationNumberOfOptions
		Defaults.creationNumberOfOptions = (optionCount ?? 2)*2
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didTapOnUpdateSize"), object: nil)
	}
	
	
	

}
