//
//  TrendingTopicCollectionViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/17/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet var tournamentTitle: UILabel!
	@IBOutlet var tournamentImage: UIImageView!
	
	static let identifier = "TrendingTopicCollectionViewCell"
	static func nib() -> UINib {
		return UINib(nibName: "TrendingTopicCollectionViewCell", bundle: nil)
	}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	public func configure (with tournament: Tournament) {
		self.tournamentTitle.text = tournament.title
		// self.tournamentImage
	}

}
