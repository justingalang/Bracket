//
//  CreationTitleTableViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/21/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class CreationTitleTableViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

	@IBOutlet weak var tournamentImageView: UIImageView!
	@IBOutlet weak var titleTextField: UITextField!
	
	static let identifier = "CreationTitleTableViewCell"
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	
}
