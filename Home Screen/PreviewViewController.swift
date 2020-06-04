//
//  PreviewViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 5/7/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

	@IBOutlet weak var tournamentTitle: UILabel!
	@IBOutlet weak var tournamentAuthor: UILabel!
	@IBOutlet weak var previewView: UITableView!
	//@IBOutlet weak var backButton: UIBarButtonItem!
	@IBOutlet weak var startButton: UIButton!
	
	var tournament: Tournament? 
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUI()
			
        // Do any additional setup after loading the view.
    }
    
	func setUI() {
		tournamentTitle.text = tournament?.title
		tournamentAuthor.text = tournament?.author
		startButton.layer.cornerRadius = 10
		startButton.layer.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
		previewView.delegate = self
		previewView.dataSource = self
	}
	
	func setTournamentTitle() {
		let navController = navigationController!
		navController.title = "test"
	}
	
	@IBAction func didTapOnBackButton(_ sender: Any) {
		dismiss(animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "PreviewToTournament" {
			let navigationController = segue.destination as! UINavigationController
			let destVC = navigationController.topViewController as! TournamentViewController
			//let destVC = segue.destination as! TournamentViewController
			destVC.tournament = sender as? Tournament
		}
	}
	@IBAction func didTapOnStart(_ sender: Any) {
		performSegue(withIdentifier: "PreviewToTournament", sender: self.tournament)
	}
	
}

extension PreviewViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print("size")
		if let tournamentSize = tournament?.size {
			print("\(tournamentSize)")
			return tournamentSize/2
		}
//		print("4")
		return 0 // Fix
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let previewNode = tournament?.rounds[0][indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell") as! PreviewCell
		cell.setOptions(node: previewNode!)
//		cell.optionOne.text = "test1"
//		cell.optionTwo.text = "test2"
		return cell
	}
	

	
}
