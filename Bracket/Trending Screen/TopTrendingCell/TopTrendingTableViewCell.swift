//
//  TopTrendingTableViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/17/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class TopTrendingTableViewCell: UITableViewCell {

	@IBOutlet weak var topTrendingImageView: UIImageView!
	@IBOutlet weak var topTrendingTitle: UILabel!
	
	static let identifier = "TopTrendingTableViewCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "TopTrendingTableViewCell", bundle: nil)
	}
	
	public func configure(with tournament: Tournament){
		self.topTrendingTitle.text = tournament.title
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
