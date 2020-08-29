//
//  CreatedTournamentsDownloader.swift
//  Bracket
//
//  Created by Justin Galang on 8/27/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import Firebase

class CreatedTournamentDownloader {
	let tournamentCollection = Firestore.firestore().collection("tournaments")
	
	func downloadCreatedTournaments(completion: @escaping ([Tournament], Error?) -> Void) {
		print("function call")
		var createdTournaments = [Tournament]()
		let dispatchGroup = DispatchGroup()
		let query = tournamentCollection.whereField("authorID", isEqualTo: Defaults.currentUserID).limit(to: 10)
		dispatchGroup.enter()
		query.getDocuments { snapshot, error in
			print("CLOSURE")
			if let error = error {
				print(error)
				completion(createdTournaments, error)
				print("ERROR")
				dispatchGroup.leave()
				return
			}
			for doc in snapshot!.documents {
				print("IN FOR LOOP")
				let tournament = Tournament(tournamentID: doc.documentID, title: doc.data()["title"] as! String,
											topic: doc.data()["topic"] as! String,
											author: doc.data()["author"] as! String,
											size: doc.data()["size"] as! Int,
											description: doc.data()["description"] as? String,
											optionTitlesList: doc.data()["options"] as! [String])
				
				createdTournaments.append(tournament)
				print("ADDED")
				dispatchGroup.leave()
			}
			
			completion(createdTournaments, nil)
		}
	}
}

