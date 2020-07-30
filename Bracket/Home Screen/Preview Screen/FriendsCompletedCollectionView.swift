//
//  FriendsCompletedCollectionView.swift
//  Bracket
//
//  Created by Justin Galang on 7/29/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class FriendsCompletedCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
	
	
	
	@IBOutlet var collectionView: UICollectionView!
	var friendsCompleted = [String]()
	
	override func awakeFromNib() {
		 collectionView.register(TrendingCollectionViewCell.nib(), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		friendsCompleted.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCompletedCollectionViewCell.identifier, for: indexPath) as! FriendsCompletedCollectionViewCell
		cell.configure(with: friendsCompleted[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 150, height: 150)
	}
	
	

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
