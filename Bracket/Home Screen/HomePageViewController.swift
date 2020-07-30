//
//  HomePageViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 4/18/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class HomePageViewController: UIViewController {
    
	@IBOutlet weak var tournamentTableView: UITableView!
	
	struct Storyboard {
		static let homeToPreview = "HomeToPreview"
		static let homeToCreation = "HomeToCreation"
	}
	
	var sampleTournamentTitles : [Tournament] = []
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
			super.viewDidLoad()
		
			let appearance = UINavigationBarAppearance()
			appearance.configureWithOpaqueBackground()
			appearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
			navigationItem.standardAppearance = appearance
			navigationItem.scrollEdgeAppearance = appearance
			navigationItem.compactAppearance = appearance
			
			tournamentTableView.dataSource = self
			tournamentTableView.delegate = self
			tournamentTableView.rowHeight = UITableView.automaticDimension
			tournamentTableView.estimatedRowHeight = 100.0
		
			var tempTitles: [Tournament] = []
		let tournament1 = Tournament(title: "Disney vs. Pixar", topic: "Movies", author: "Justin Galang", size: 32, description: "This is a test", optionTitlesList: ["Lion King", "Tarzan", "Princess and The Frog", "Lilo and Stitch", "Tangled", "Big Hero 6", "Frozen", "Moana",  "Aladdin", "Hercules", "Little Mermaid","Pocahontas", "Mulan", "Zootopia", "Beauty and The Beast", "Nightmare Before Christmas", "UP",  "Brave", "Toy Story","Toy Story 2",  "Coco",  "Cars 2", "Toy Story 3", "The Good Dinosaur", "Ratatouille", "Bugs Life", "Nemo",  "Inside Out", "Monsters Inc.", "Cars", "Incredibles", "Wall-E"])
		
			let tournament2 = Tournament(title: "One Direction Songs", topic: "Music", author: "Jace", size: 32, description: "This is a Test", optionTitlesList: ["Drag Me Down", "strong", "One Thing", "If I Could Fly", "Best Song Ever", "Midnight Memories", "Little Things", "What A Feeling", "Perfect", "Half A Heart", "No Control", "End of A Day", "You&I", "Stockholm Syndrome", "What Makes You Beautiful", "Rock Me", "Story of My Life", "More Than This", "They Don't Know About Us", "A.M", "Kiss You", "Where Do Broken Hearts Go", "Night Changes", "Olivia", "History", "Happily", "Live While You're Young", "18", "Infinity", "Love You Goodbye", "Steal My Girl", "Fireproof"])
		
			let tournament3 = Tournament(title: "Popular Country Hits",  topic: "Music", author: "Addison", size: 16, description: "This is a test", optionTitlesList: ["Luke Bryan", "Kelsea Ballerini", "Eric Church", "Zac Brown Band", "Tim McGraw", "Thomas Rhett", "Keith Urban", "Brett Eldredge", "Blake Shelton", "Little Big Town", "Miranda Lambert", "Florida Georgia Line", "Carrie Underwood", "Dierks Bentley", "Kenny Chesney", "Sam Hunt" ])
		
			let tournament4 = Tournament(title: "Beatles Songs",  topic: "Music", author: "Justin", size: 64, description: "This is a test", optionTitlesList: ["Love Me Do", "The Long & Winding Road", "Tomorrow Never Knows", "Yellow Submarine", "I've Just Seen a Face", "Ob-La-Di Ob-La-Da", "Ticket to Ride", "While My Guitar Gently Weeps", "A Hard Day's Night", "Come Together", "Michelle", "Hello Goodbye", "Girl", "All You Need Is Love", "I Want To Hold Your Hand", "Something", "Twist & Shout", "Octupus's Garden", "Eleanor Rigby", "Sgt. Pepper's Lonely Heart's Club Band", "We Can Work It Out", "Revolution", "Eight Days A Week", "Helter Skelter", "I Feel Fine", "Get Back", "Drive My Car", "Hey Jude", "Taxman", "With A Little Help From My Friends", "From Me To You", "Here Comes The Sun", "Please Please Me", "Across The Universe", "Got to Get You Into My Life", "Strawberry Fields Forever", "Yesterday", "Dear Prudence", "You've Got to Hide Your Love Away", "Happiness Is a Warm Gun", "And I Love Her", "The Ballad of John & Yoko", "Nowhere Man", "I Am The Walrus", "In My Life", "A Day In The Life", "All My Loving", "Oh Darling", "I Saw Her Standing There", "Let It Be", "Here, There, and Everywhere", "Penny Lane", "Day Tripper", "Back In The USSR", "Help!", "Blackbird", "Can't Buy Me Love", "Don't Let Me Down", "Norwegian Wood", "Lady Madonna", "Paperback Writer", "Lucy In The Sky With Diamonds", "She Loves You", "Abbey Road Medley"])
		
			tempTitles.append(tournament1)
			tempTitles.append(tournament2)
			tempTitles.append(tournament3)
			tempTitles.append(tournament4)
			
			sampleTournamentTitles = tempTitles
			addNavBarImage()
	}
	
	func addNavBarImage() {
		let navController = navigationController!
		
		let image = #imageLiteral(resourceName: "PrototypeLogo")
		let imageView = UIImageView(image: image)
		
		let bannerWidth = navController.navigationBar.frame.size.width
		let bannerHeight = navController.navigationBar.frame.size.height
		
		let bannerX = bannerWidth/2 - image.size.width/2
		let bannerY = bannerHeight/2 - image.size.height/2
		
		imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
		imageView.contentMode = .scaleAspectFit
		
		navigationItem.titleView = imageView
	}
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Storyboard.homeToPreview{
			let navigationController = segue.destination as! UINavigationController
			let destVC = navigationController.topViewController as! PreviewViewController
			destVC.tournament = sender as? Tournament
		}
	}
	
	
	@IBAction func didPressCreate(_ sender: Any) {
		Defaults.creationTournamentSize = 2
		Defaults.creationTournamentOptionsArray = []
		performSegue(withIdentifier: Storyboard.homeToCreation, sender: Any?.self)
		
	}
	
	@IBAction func unwindToHome(_ sender: UIStoryboardSegue) {}
}


extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sampleTournamentTitles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tournamentOption = sampleTournamentTitles[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: TournamentOptionCell.identifier) as! TournamentOptionCell
		cell.setTournament(tournament: tournamentOption)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let tournament = sampleTournamentTitles[indexPath.row]
		performSegue(withIdentifier: Storyboard.homeToPreview, sender: tournament)
	}
}

