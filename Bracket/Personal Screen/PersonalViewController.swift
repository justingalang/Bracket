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
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	let db = Firestore.firestore()
	let userdoc = Firestore.firestore().collection("users").document(Defaults.currentUserID)
	let tournamentCollection = Firestore.firestore().collection("tournaments")
	let createdTournamentsDownloader = CreatedTournamentDownloader()
	var createdTournaments = [Tournament]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUI()
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 120, height: 120)
		createdTournamentCollectionView.collectionViewLayout = layout
		createdTournamentCollectionView.register(CreatedTournamentViewCell.nib(), forCellWithReuseIdentifier: CreatedTournamentViewCell.identifier)
		createdTournamentCollectionView.delegate = self
		createdTournamentCollectionView.dataSource = self
		
		
	}

	func setUI() {
		self.title = Defaults.currentUserUserName
		username.text = Defaults.currentUserUserName
		firstlastName.text = "\(Defaults.currentUserFirstName) \(Defaults.currentUserLastName)"
		getCreatedTournaments()
		print("THIS IS THE TOURNAMENT COUNT: \(createdTournaments.count)")
	}
	
	
	func getCreatedTournaments() {
		activityIndicator.startAnimating()
		createdTournamentsDownloader.downloadCreatedTournaments() { tournamentsArray, error in
		  self.activityIndicator.stopAnimating()
		  if let error = error {
			self.alert(title: "Error", message: error.localizedDescription)
			return
		  }
		  self.createdTournaments = tournamentsArray
		  self.createdTournamentCollectionView.reloadData()
		}
	}
	
	func alert(title: String, message: String) {
	  let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
	  let action = UIAlertAction(title: "OK", style: .default, handler: nil)
	  alertController.addAction(action)
	  navigationController?.present(alertController, animated: true, completion: nil)
	}
	
}




extension PersonalViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print("THIS IS THE COUNT: \(createdTournaments.count)")
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let tournament = createdTournaments[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatedTournamentViewCell.identifier, for: indexPath) as! CreatedTournamentViewCell
		cell.configure(with: tournament)
		return cell
	}
}

extension PersonalViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("You tapped")
	}
}

extension PersonalViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 120, height: 120)
	}
	
}

