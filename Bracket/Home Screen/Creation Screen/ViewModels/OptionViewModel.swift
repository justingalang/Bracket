//
//  OptionViewModel.swift
//  Bracket
//
//  Created by Justin Galang on 7/24/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation
import UIKit

class OptionViewModel : NSObject, UITextFieldDelegate {
	private(set) var text = ""
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		text = textField.text ?? ""
	}
	
	
	
}
