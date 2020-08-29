//
//  CreationPublishViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/26/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Firebase

class CreationPublishViewController: UIViewController {
	
	//@IBOutlet weak var tournamentTitle: UILabel!
	@IBOutlet weak var topic: UILabel!
	@IBOutlet weak var author: UILabel!
	@IBOutlet weak var authorImage: UIImageView!
	@IBOutlet weak var previewSize: UILabel!
	@IBOutlet weak var optionPreview: UITableView!
	
	@IBOutlet weak var tournamentPicture: UIImageView!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	let db = Firestore.firestore()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUI()
		
		// Do any additional setup after loading the view.
	}
	
	func setUI() {
		self.title = Defaults.creationTournamentTitle
		author.text = Defaults.currentUserUserName
		
		if Defaults.creationTournamentTopic == "" || Defaults.creationTournamentTopic == "None" {
			topic.text = ""
		} else {
			topic.text = Defaults.creationTournamentTopic
		}
		previewSize.text = "Tournament Preview: \(Defaults.creationTournamentSize ?? 0)"
		
		descriptionTextView.delegate = self
		descriptionTextView.text = "Write a description..."
		descriptionTextView.textColor = .lightGray
		optionPreview.delegate = self
		optionPreview.dataSource = self
		optionPreview.rowHeight = UITableView.automaticDimension
		optionPreview.estimatedRowHeight = 100.0
	}
	
	@IBAction func didPressPublish(_ sender: Any) {
		let db = Firestore.firestore()
		let tournamentCollection = db.collection("tournaments")
		let tournamentID = tournamentCollection.document().documentID
		
		//Add tournament to collection
		tournamentCollection.document(tournamentID).setData(
			["tournamentID": tournamentID,
			 "title": Defaults.creationTournamentTitle,
			 "author": Defaults.currentUserUserName,
			 "authorID": Defaults.currentUserID,
			 "topic": Defaults.creationTournamentTopic,
			 "description": descriptionTextView!.text as String,
			 "size": Defaults.creationTournamentSize! as Int,
			 "options": Defaults.creationTournamentOptionsArray]) { (error) in
				if error != nil {
					//Show error message
					print("Error saving tournament")
				}
			}
				
		//add tournament ID and display info to user
		let userCollection = db.collection("users")
		let currentUserTournamentsCollection = userCollection.document(Defaults.currentUserID).collection("createdTournaments").document(tournamentID)
		currentUserTournamentsCollection.setData(
		["tournamentID": tournamentID]) { (error) in
			if error != nil {
				print("Error Saving tournament to user")
			}
		}
		
		//increment user's created tournament count
		let value: Double = 1
		userCollection.document(Defaults.currentUserID).updateData(["createdTournamentCount": FieldValue.increment(value)])
		
		//return to home
		self.transitionToHome()
	}
	
	func transitionToHome() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController)
		
		// This is to get the SceneDelegate object from your view controller
		// then call the change root view controller function to change to main tab bar
		(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
	}
}
	
	
	
extension CreationPublishViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (Defaults.creationTournamentSize ?? 2)/2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PreviewCell.identifier) as! PreviewCell
		cell.setOptions(optionOneText: Defaults.creationTournamentOptionsArray[2*indexPath.row], optionTwoText: Defaults.creationTournamentOptionsArray[2*indexPath.row + 1])
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
}

	
extension CreationPublishViewController: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView)
	{
		if (textView.text == "Write a description..." && textView.textColor == .lightGray)
		{
			textView.text = ""
			textView.textColor = .black
		}
		textView.becomeFirstResponder() //Optional
	}
	
	func textViewDidEndEditing(_ textView: UITextView)
	{
		if (textView.text == "")
		{
			textView.text = "Write a description..."
			textView.textColor = .lightGray
		}
		textView.resignFirstResponder()
	}
}

