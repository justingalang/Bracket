//
//  Tournament.swift
//  BrackIt
//
//  Created by Justin Galang on 5/5/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation
import UIKit

class Tournament {
	
	//var thumbnail: UIImageView?
	var title: String
	var author: String
	var size: Int
	var description: String?
	var optionTitlesList: [String]
	var optionList: [Option] = []
	var rounds: [[Node]] = []
	var roundIndex: Int
	var nodeIndex: Int
	
	
	init() {
		self.title = ""
		self.author = ""
		self.size = 0
		self.description = " "
		self.optionTitlesList = []
		self.roundIndex = 0
		self.nodeIndex = 0
	}
	
	/// Tournament Constructor
	/// - Parameters:
	///   - title: Title of the tournament
	///   - author: Name of the author
	///   - size: Count of how many options
	///   - description: Description of the tournament
	///   - optionTitlesList: All titles of the option
	init(/*thumbnail: UIImageView?,*/ title: String, author: String, size: Int, description: String?, optionTitlesList: [String]) {
		self.title = title
		self.author = author
		self.size = size
		self.description = description
		self.optionTitlesList = optionTitlesList
		self.roundIndex = 0
		self.nodeIndex = 0
		
		for optionTitles in optionTitlesList {
			optionList.append(Option(label: optionTitles))
		}
		
		createFirstRound()
	}
	
	/// Creates the first round of the tournamnent
	func createFirstRound() {
		var firstRound: [Node] = []
		for i in 0..<size/2 {
			firstRound.append(Node(optionOne: optionList[2*i], optionTwo: optionList[(2*i)+1]))
		}
		rounds.append(firstRound)
	}
	
	/// Goes to next node of the tournament
	func nextNode() {
		if endOfTournament() {
			return
		} else if endOfRound() && roundIsComplete() {
			createNextRound()
			roundIndex += 1
			nodeIndex = 0
		} else if !endOfRound() && !roundIsComplete() {
			nodeIndex += 1
		} else if endOfRound() && !roundIsComplete() {
			// return back to incomplete node
			return
		} else {
			return
		}
		
	}
	
	/// Goes to previous node of the round
	func prevNode() {
		if nodeIndex != 0 {
			nodeIndex -= 1
		} else {
			return
		}
	}
	
	
	/// Creates the next round of the tournament
	func createNextRound() {
		//get winning titles
        var winningTitles: [String] = []
        for node in rounds[roundIndex] {
            if node.optionOne.status == .win {
                winningTitles.append(node.optionOne.label)
            } else if node.optionTwo.status == .win {
                winningTitles.append(node.optionTwo.label)
            }
        }
		
        //create options from titles
		var winningOptions: [Option] = []
        for title in winningTitles {
			winningOptions.append(Option(label: title))
        }
		
        //make NEW round of winning options
		var winners: [Node] = []
        for i in 0..<winningTitles.count/2 {
			winners.append(Node(optionOne: winningOptions[2*i], optionTwo: winningOptions[(2*i)+1]))
        }
        
        for node in winners {
            print("\(node.optionOne.label), \(node.optionTwo.label)")
        }
		
        //add round to round list
        rounds.append(winners)
	}
	
	/// Checks if it is the end of the round
	/// - Returns: returns true if it is the end
	func endOfRound() -> Bool {
        if nodeIndex == rounds[roundIndex].count - 1  {
            return true
        } else {
            return false
        }
	}
	
	/// Checks if round is complete
	/// - Returns: returns true if it is complete
	func roundIsComplete() -> Bool {
		for i in 0..<rounds[roundIndex].count {
			if rounds[roundIndex][i].optionOne.status == .unselected {
				return false
			}
		}
		return true
	}
	
	/// Checks if it is the end of the Tournament
	/// - Returns: returns true if end of the tournament
	func endOfTournament() -> Bool {
		if endOfRound() && roundIsComplete() && nodeIndex == 0 {
			return true
		} else {
			return false
		}
	}
	
	func getCurrentNode() -> Node {
		return rounds[roundIndex][nodeIndex]
	}
	
	func getOptionOneLabel() -> String {
		return rounds[roundIndex][nodeIndex].optionOne.label
	}
	
	func getOptionTwoLabel() -> String {
		return rounds[roundIndex][nodeIndex].optionTwo.label
	}
	
	func optionOneWins() {
		rounds[roundIndex][nodeIndex].optionOne.setWin()
		rounds[roundIndex][nodeIndex].optionTwo.setLose()
	}
	
	func optionTwoWins() {
		rounds[roundIndex][nodeIndex].optionOne.setLose()
		rounds[roundIndex][nodeIndex].optionTwo.setWin()
	}
}
