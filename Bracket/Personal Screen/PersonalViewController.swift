//
//  PersonalViewController.swift
//  Bracket
//
//  Created by Justin Galang on 8/19/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Firebase

class PersonalViewController: UIViewController {

	@IBOutlet weak var username: UILabel!
	@IBOutlet weak var firstlastName: UILabel!
	@IBOutlet weak var createdTournamentCollectionView: UICollectionView!
	let doc = Firestore.firestore().collection("users").document(Defaults.currentUserID)
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		createdTournamentCollectionView.delegate = self
		createdTournamentCollectionView.dataSource = self
		
		
		doc.getDocument { (document, error) in
			if let document = document, document.exists {
				let createdTournamentIDs = document.data()?["tournaments"]! as! [Any]
				print(createdTournamentIDs[0])
				
				
			} else {
				print("ERROR RETRIEVING DOC : \(String(describing: error?.localizedDescription))")
			}
		}
		setUI()
        
    }
	
	func setUI() {
		self.title = Defaults.currentUserUserName
		username.text = Defaults.currentUserUserName
		firstlastName.text = "\(Defaults.currentUserFirstName) \(Defaults.currentUserLastName)"
	}
}



extension PersonalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		var createdTournamentCount : Int
		doc.getDocument { (document, error) in
			if let document = document, document.exists {
				let dataDescription = document.data()
				createdTournamentCount = dataDescription?["createdTournamentCount"] as! Int
			} else {
				print("ERROR RETRIEVING DOC : \(String(describing: error?.localizedDescription))")
			}
		}
		return createdTournamentCount
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let tournament = sampleTournamentTitles[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withIdentifier: CreatedTournamentViewCell.identifier) as! CreatedTournamentViewCell
		cell.setTournament(tournament: tournamentOption)
		return cell
	}
}
