//
//  CreationDetailViewController.swift
//  Bracket
//
//  Created by Justin Galang on 7/22/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import iOSDropDown

class CreationDetailViewController: UIViewController {
	
	struct Storyboard {
		static let detailToPublish = "DetailToPublish"
	}
	
	@IBOutlet weak var tournamentSize: UILabel!
	@IBOutlet weak var topicSelector: DropDown!
	@IBOutlet weak var tournamentTitle: UITextField!
	let TITLE_CHARACTER_COUNT_LIMIT = 25
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(CreationDetailViewController.didPressNext(_:)))

		topicSelector.optionArray = ["Music", "Movie", "Book", "Game", "Celeb", "Other","None"]
		NotificationCenter.default.addObserver(self, selector: #selector(updateTournamentSize), name: NSNotification.Name(rawValue: "didTapOnIncreaseSize"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateTournamentSize), name: NSNotification.Name(rawValue: "didTapOnDecreaseSize"), object: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Storyboard.detailToPublish {
			let navigationController = segue.destination as! UINavigationController
			_ = navigationController.topViewController as! CreationPublishViewController
			//let destVC = CreationPublishViewController()
		}
	}
	
	@objc func updateTournamentSize() {
		tournamentSize.text = "\(Defaults.creationTournamentSize ?? 0)"
	}
		
	@IBAction func didPressNext(_ sender: Any) {
		print("Did PRESS NEXT")
		//Tournament Title
		guard let title = tournamentTitle.text, titleIsValid(title: title) else {
			let alert = UIAlertController(title: "Tournament Title", message: "Please make sure your tournament's title is between 4 to 25 characters" , preferredStyle: .alert)
			let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
			present(alert, animated: true)
			return
		}
		//Tournament Topic
		guard let topic = topicSelector.text, topicIsValid(topic: topic) else {
			let alert = UIAlertController(title: "Tournament Topic", message: "Please make sure you've selected a topic" , preferredStyle: .alert)
			let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
			present(alert, animated: true)
			return
		}
		//Tournament options
//		if !(optionsAreValid(options: Defaults.creationTournamentOptionsArray)) {
//			let alert = UIAlertController(title: "Tournament Options", message: "You have not filled out all your options" , preferredStyle: .alert)
//			let okAction = UIAlertAction(title: "Ok", style: .default)
//            alert.addAction(okAction)
//			present(alert, animated: true)
//			return
//		}
		Defaults.creationTournamentTopic = topicSelector.text ?? " "
		Defaults.creationTournamentTitle = tournamentTitle.text!
		Defaults.creationTournamentSize = Int(tournamentSize.text!)
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didPressNext"), object: nil)
		print(Defaults.creationTournamentTopic)
		print(Defaults.creationTournamentTitle)
		print("\(Defaults.creationTournamentSize ?? 0)")
		print(Defaults.creationTournamentOptionsArray)
		
		performSegue(withIdentifier: Storyboard.detailToPublish, sender: nil)
	}
	
	func titleIsValid(title: String) -> Bool {
		// check the name is between 4 and 25 characters
		if !(4...25 ~= title.count) {
			return false
		}
		return true
	}
	
	func topicIsValid(topic: String) -> Bool {
		//check if topic is not blank AND is one of the selected
		if topic == "" || topic == "Topic" {
			return false
		}
		return true
	}
	func optionsAreValid(options: [String]) -> Bool {
		//check if each element of the array AND the array is the same count as the size
		for option in options {
			if option == "" {
				return false
			}
		}
		if options.count != Defaults.creationTournamentSize {
			return false
		}
		return true
	}
	
	
	@IBAction func unwindToCreationDetail(_ sender: UIStoryboardSegue) {}
	
	
	
	

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
