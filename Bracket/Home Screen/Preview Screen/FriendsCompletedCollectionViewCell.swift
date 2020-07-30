//
//  FriendsCompletedCollectionViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/29/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class FriendsCompletedCollectionViewCell: UICollectionViewCell {
	static let identifier = "FriendsCompletedCollectionViewCell"
	@IBOutlet weak var userPicture: UIImageView!
	@IBOutlet weak var userName: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	public func configure(with username: String) {
		self.userName.text = username
	}
}
