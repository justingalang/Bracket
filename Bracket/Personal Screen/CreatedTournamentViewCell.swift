//
//  CreatedTournamentViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 8/26/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class CreatedTournamentViewCell: UICollectionViewCell {
	static let identifier = "CreatedTournamentViewCell"
	
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var topic: UILabel!
	@IBOutlet weak var size: UILabel!
	
	static func nib() -> UINib {
		return UINib(nibName: "CreatedTournamentViewCell", bundle: nil)
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	public func configure(with tournament: Tournament) {
		title.text = tournament.title
		topic.text = tournament.topic
		size.text = "\(tournament.size)"
	}

}
