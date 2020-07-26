//
//  TrendingTableViewCell.swift
//  Bracket
//
//  Created by Justin Galang on 7/17/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class TrendingTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	static let identifier = "TrendingTableViewCell"
	static func nib() -> UINib {
		return UINib(nibName: "TrendingTableViewCell", bundle: nil)
	}
	
	var trendingTopic = TrendingTopic()
	func configure(with topic: TrendingTopic) {
		self.trendingTopic = topic
		collectionView.reloadData()
	}
	
	@IBOutlet var collectionView: UICollectionView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		collectionView.register(TrendingCollectionViewCell.nib(), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	//Collection View
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return trendingTopic.tournaments.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
		cell.configure(with: trendingTopic.tournaments[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 130, height: 130)
	}
    
}
