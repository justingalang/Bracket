//
//  PreviewCell.swift
//  BrackIt
//
//  Created by Justin Galang on 5/9/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class PreviewCell: UITableViewCell {
	
	@IBOutlet weak var optionOne: UILabel!
	@IBOutlet weak var optionTwo: UILabel!
	
	func setOptions(node: Node) {
		optionOne.text = node.optionOne.label
		optionTwo.text = node.optionTwo.label
	}
//	override func awakeFromNib() {
//			super.awakeFromNib()
//			// Initialization code
//	}
//
//	override func setSelected(_ selected: Bool, animated: Bool) {
//			super.setSelected(selected, animated: animated)
//
//			// Configure the view for the selected state
//	}

}