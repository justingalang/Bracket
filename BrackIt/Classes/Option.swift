//
//  Option.swift
//  BrackIt
//
//  Created by Justin Galang on 5/15/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation

class Option {
	enum Status {
		case win
		case lose
		case unselected
	}
	
	var label: String
	var status: Status
	init(label: String) {
		self.label = label
		self.status = .unselected
	}
	
	func setWin() {
		status = .win
	}
	
	func setLose() {
		status = .lose
	}
}
