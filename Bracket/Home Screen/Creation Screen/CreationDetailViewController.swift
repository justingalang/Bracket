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
	
	@IBOutlet weak var tournamentSize: UILabel!
	@IBOutlet weak var topicSelector: DropDown!
	@IBOutlet weak var tournamentTitle: UITextField!
	let TITLE_CHARACHTER_COUNT_LIMIT = 25
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(CreationDetailViewController.didPressNext(_:)))
		
		topicSelector.optionArray = ["Music", "Movie", "Book", "Game", "Celeb", "Other","None"]
		NotificationCenter.default.addObserver(self, selector: #selector(updateTournamentSize), name: NSNotification.Name(rawValue: "didTapOnIncreaseSize"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateTournamentSize), name: NSNotification.Name(rawValue: "didTapOnDecreaseSize"), object: nil)
	}
	
	@objc func updateTournamentSize() {
		tournamentSize.text = "\(Defaults.creationTournamentSize ?? 0)"
	}
		
	@IBAction func didPressNext(_ sender: Any) {
		print("Did PRESS NEXT")
		guard let title = tournamentTitle.text, titleIsValid(title: title) else {
			let alert = UIAlertController(title: "Tournament Title", message: "Please make sure your tournament's title is between 4 to 25 characters" , preferredStyle: .alert)
			let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
			present(alert, animated: true)
			return
		}
		Defaults.creationTournamentTopic = topicSelector.text ?? " "
		Defaults.creationTournamentTitle = tournamentTitle.text!
		Defaults.creationTournamentSize = Int(tournamentSize.text!)
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didPressNext"), object: nil)
		print(Defaults.creationTournamentTopic)
		print(Defaults.creationTournamentTitle)
		print("\(Defaults.creationTournamentSize ?? 0)")
		print(Defaults.creationTournamentOptionsArray)
	}
	
	func titleIsValid(title: String) -> Bool {
		// check the name is between 4 and 25 characters
		if !(4...25 ~= title.count) {
			return false
		}
		return true
	}
	
	func optionsIsValid(options: [String], size: Int) -> Bool {
		if options.count != size {
			return false
		}
		return true
	}
	
	
	
	

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
