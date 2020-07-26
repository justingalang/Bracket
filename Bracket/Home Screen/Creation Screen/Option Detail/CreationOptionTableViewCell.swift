//
//  CreationOptionTableViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/21/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class CreationOptionTableViewCell: UITableViewCell {
	
	@IBOutlet weak var optionOneTextField: UITextField!
	@IBOutlet weak var optionTwoTextField: UITextField!
	
	static let identifier = "CreationOptionTableViewCell"
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func load(viewModel: OptionViewModel) {
		optionOneTextField.text = viewModel.text
		optionOneTextField.delegate = viewModel
		
		optionTwoTextField.text = viewModel.text
		optionTwoTextField.delegate = viewModel
	}
}
