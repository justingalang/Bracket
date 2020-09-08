//
//  PreviewViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 5/7/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

	@IBOutlet weak var tournamentTopic: UILabel!
	@IBOutlet weak var tournamentSize: UILabel!
	@IBOutlet weak var tournamentCompletionCount: UILabel!
	@IBOutlet weak var tournamentDescription: UITextView!
	@IBOutlet weak var tournamentFriendsCollectionView: UICollectionView!
	@IBOutlet weak var tournamentImage: UIImageView!
	@IBOutlet weak var tournamentTitle: UILabel!
	@IBOutlet weak var tournamentAuthor: UILabel!
	@IBOutlet weak var previewView: UITableView!

	//@IBOutlet weak var backButton: UIBarButtonItem!
	@IBOutlet weak var startButton: UIButton!
	
	
	struct Storyboard {
		static let previewToTournament = "PreviewToTournament"
	}
	
	var tournament: Tournament? 
	var friendsCompleted = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		friendsCompleted = ["BKP", "Elena P", "Victor W.", "Jaden G"]
		tournamentFriendsCollectionView.register(UINib(nibName: "FriendsCompletedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FriendsCompletedCollectionViewCell.identifier)

		setUI()
		
			
        // Do any additional setup after loading the view.
    }
    
	func setUI() {
		self.title = tournament?.title
		tournamentSize.text = ("Tournament Preview: \(tournament?.size ?? 2)")
		tournamentTopic.text = tournament?.topic
		tournamentAuthor.text = tournament?.author
		tournamentDescription.text = "This is a test description to see how a scroll view works. bladi bladi blah blah blah blah. I hope this everything will run okay. One day, Ill finish that book and I will make a really successful app."
		
		startButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
		startButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
		startButton.layer.shadowOpacity = 1.0
		startButton.layer.shadowRadius = 10.0
		startButton.layer.masksToBounds = false
		startButton.layer.cornerRadius = 6.0

		previewView.delegate = self
		previewView.dataSource = self
		tournamentFriendsCollectionView.delegate = self
		tournamentFriendsCollectionView.dataSource = self
	}
	
	@IBAction func didTapOnBackButton(_ sender: Any) {
		dismiss(animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Storyboard.previewToTournament {
			let navigationController = segue.destination as! UINavigationController
			let destVC = navigationController.topViewController as! TournamentViewController
			destVC.tournament = sender as? Tournament
		}
	}
	@IBAction func didTapOnStart(_ sender: Any) {
		self.tournament!.resetTournament()
		performSegue(withIdentifier: Storyboard.previewToTournament, sender: self.tournament)
	}
	
}

extension PreviewViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("size")
		if let tournamentSize = tournament?.size {
			print("\(tournamentSize)")
			return tournamentSize/2
		}
		return 0 // Fix
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let previewNode = tournament?.rounds[0][indexPath.row]
		let cell = previewView.dequeueReusableCell(withIdentifier: PreviewCell.identifier) as! PreviewCell
		cell.setOptions(node: previewNode!)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
}

extension PreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		friendsCompleted.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCompletedCollectionViewCell.identifier, for: indexPath) as! FriendsCompletedCollectionViewCell
		cell.configure(with: friendsCompleted[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 50, height: 50)
	}
	
}

