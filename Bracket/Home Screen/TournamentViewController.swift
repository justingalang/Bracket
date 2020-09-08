//
//  TournamentViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 5/4/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
//import Firebase

class TournamentViewController: UIViewController {
	struct Direction {
		static let forward = "forward"
		static let prev = "prev"
	}
	
	var tournament : Tournament?
	
	@IBOutlet var tournamentView: UIView!
	@IBOutlet weak var choicesView: UIView!
	
	@IBOutlet weak var choiceOneView: UIView!
	@IBOutlet weak var choiceTwoView: UIView!
	
	@IBOutlet weak var choiceOneLabel: UILabel!
	@IBOutlet weak var choiceTwoLabel: UILabel!
	
	//@IBOutlet weak var tournamentProgress: UIProgressView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//Screen Style
		tournamentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		//Choice styles
		choiceOneView.layer.cornerRadius = 20.0
		choiceTwoView.layer.cornerRadius = 20.0
		//label style
		choiceOneLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		choiceOneLabel.layer.cornerRadius = 20.0
		choiceOneLabel.clipsToBounds = true
		choiceTwoLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		choiceTwoLabel.layer.cornerRadius = 20.0
		choiceTwoLabel.clipsToBounds = true
		self.navigationController?.title = tournament?.title
		updateChoices()
	}
	
	/// Change choice one and choice two to enum - switch-case events
	@IBAction func didTapOnChoiceOne(_ sender: Any) {
		tournament?.optionOneWins()
		tournament?.nextNode()
		animateChoicesOut(direction: Direction.forward)
	}
	
	@IBAction func didTapOnChoiceTwo(_ sender: Any) {
		tournament?.optionTwoWins()
		tournament?.nextNode()
		animateChoicesOut(direction: Direction.forward)
	}
	
	/// Swipe to previous choices
	@IBAction func didSwipeBack(_ sender: Any) {
		/*ADD SWITCH CASE HERE FOR DIRECTIONS*/
		if !(tournament?.atBeginning())! {
			tournament?.prevNode()
			animateChoicesOut(direction: Direction.prev)
		}
	}
	
	/// Swipe to next choices
	@IBAction func didSwipeForward(_ sender: Any) {
		if tournament?.getCurrentNode().optionOne.status == .lose ||
			tournament?.getCurrentNode().optionOne.status == .win {
			tournament?.nextNode()
			animateChoicesOut(direction: "forward")
		} else {
			return
		}
	}
	
	/// animation for swiping back
	func animateChoicesOut(direction: String) {
		var translateDist = -530
		//change direction
		if direction == Direction.prev {
			translateDist *= -1
		}
		
		//animate View
		UIView.animate(withDuration: 0.3, animations: {
			self.choicesView.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: CGFloat(translateDist))
		}, completion: { finished in
			self.updateChoices()
			self.animateChoicesIn(direction: direction)
		})
	}
	
	func animateChoicesIn(direction: String){
		var translateDist = 530
		if direction == Direction.prev {
			translateDist *= -1
		}
		
		choicesView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: CGFloat(translateDist))
		
		UIView.animate(withDuration: 0.3, animations: {
			self.choicesView.transform = CGAffineTransform.identity
		})
	}
	
	/// update Choice Views and Labels
	func updateChoices() {
		choiceOneLabel.text = tournament?.getCurrentNode().optionOne.label
		choiceTwoLabel.text = tournament?.getCurrentNode().optionTwo.label
		
		if tournament?.getCurrentNode().optionOne.status == .unselected && tournament?.getCurrentNode().optionTwo.status == .unselected {
			choiceOneLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			choiceOneLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			choiceOneView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			choiceOneView.layer.borderWidth = 3.0
			
			choiceTwoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			choiceTwoLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			choiceTwoView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			choiceTwoView.layer.borderWidth = 3.0
			
		} else if tournament?.getCurrentNode().optionOne.status == .win && tournament?.getCurrentNode().optionTwo.status == .lose {
			//show option one selected
			choiceOneLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
			choiceOneLabel.backgroundColor = #colorLiteral(red: 0.9030977488, green: 1, blue: 1, alpha: 1)
			choiceOneView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
			choiceOneView.layer.borderWidth = 4.0
			
			//show option two unselected
			choiceTwoLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
			choiceTwoLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			choiceTwoView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
			choiceTwoView.layer.borderWidth = 2.0
		} else if tournament?.getCurrentNode().optionOne.status == .lose && tournament?.getCurrentNode().optionTwo.status == .win {
			//show option two selected
			choiceTwoLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
			choiceTwoLabel.backgroundColor = #colorLiteral(red: 0.9019607843, green: 1, blue: 1, alpha: 1)
			choiceTwoView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
			choiceTwoView.layer.borderWidth = 4.0
			
			//show option one unselected
			choiceOneLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
			choiceOneLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			choiceOneView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
			choiceOneView.layer.borderWidth = 2.0
		}
	}
	
	func finalChoiceAction(){
		
	}
	
}
