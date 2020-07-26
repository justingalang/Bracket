//
//  TournamentViewModel.swift
//  Bracket
//
//  Created by Justin Galang on 7/24/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation

struct TournamentViewModel {
	//var thumbnail: UIImageView?
	var title: String
	var topic: String?
	var author: String
	var size: Int
	
	init(title: String, topic: String?, author: String, size: Int){
		self.title = title
		self.topic = topic
		self.author = author
		self.size = size
	}
}
