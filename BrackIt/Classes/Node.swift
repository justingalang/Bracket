//
//  Node.swift
//  BrackIt
//
//  Created by Justin Galang on 5/15/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation

class Node {
	var optionOne : Option
	var optionTwo : Option
	
	init(optionOne: Option, optionTwo: Option) {
		self.optionOne = optionOne
		self.optionTwo = optionTwo
	}
}
