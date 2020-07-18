//
//  TrendingTopic.swift
//  Bracket
//
//  Created by Justin Galang on 7/18/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation
class TrendingTopic {
	var topic : String
	var tournaments : [Tournament]
	
	init(topic: String, tournaments: [Tournament]) {
		self.topic = topic
		self.tournaments = tournaments
	}
}
