//
//  TrendingViewController.swift
//  BrackIt
//
//  Created by Justin Galang on 7/14/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var topTrending = Tournament()
	var trendingTopics : [TrendingTopic] = []
	
	private let tableView: UITableView = {
		let table = UITableView()
		table.register(TopTrendingTableViewCell.nib(), forCellReuseIdentifier: TopTrendingTableViewCell.identifier)
		table.register(TrendingTableViewCell.nib(), forCellReuseIdentifier: TrendingTableViewCell.identifier)
		return table
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupNavBar()
		
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		
		//TEMPORARY Top Tournament
		let tempTopTrending = Tournament(tournamentID: "tempID", title: "Disney vs. Pixar", topic: "Movies", author: "Justin Galang", size: 32, description: "This is a test", optionTitlesList: ["Lion King", "Tarzan", "Princess and The Frog", "Lilo and Stitch", "Tangled", "Big Hero 6", "Frozen", "Moana",  "Aladdin", "Hercules", "Little Mermaid","Pocahontas", "Mulan", "Zootopia", "Beauty and The Beast", "Nightmare Before Christmas", "UP",  "Brave", "Toy Story","Toy Story 2",  "Coco",  "Cars 2", "Toy Story 3", "The Good Dinosaur", "Ratatouille", "Bugs Life", "Nemo",  "Inside Out", "Monsters Inc.", "Cars", "Incredibles", "Wall-E"])
		topTrending = tempTopTrending
		
		//TEMPORARY Topic
		var tempTitles: [Tournament] = []
		let tournament1 = Tournament(tournamentID: "tempID", title: "One Direction Songs", topic: "Music", author: "Jace", size: 32, description: "This is a Test", optionTitlesList: ["Drag Me Down", "strong", "One Thing", "If I Could Fly", "Best Song Ever", "Midnight Memories", "Little Things", "What A Feeling", "Perfect", "Half A Heart", "No Control", "End of A Day", "You&I", "Stockholm Syndrome", "What Makes You Beautiful", "Rock Me", "Story of My Life", "More Than This", "They Don't Know About Us", "A.M", "Kiss You", "Where Do Broken Hearts Go", "Night Changes", "Olivia", "History", "Happily", "Live While You're Young", "18", "Infinity", "Love You Goodbye", "Steal My Girl", "Fireproof"])
		
		let tournament2 = Tournament(tournamentID: "tempID", title: "Popular Country Hits",  topic: "Music", author: "Addison", size: 16, description: "This is a test", optionTitlesList: ["Luke Bryan", "Kelsea Ballerini", "Eric Church", "Zac Brown Band", "Tim McGraw", "Thomas Rhett", "Keith Urban", "Brett Eldredge", "Blake Shelton", "Little Big Town", "Miranda Lambert", "Florida Georgia Line", "Carrie Underwood", "Dierks Bentley", "Kenny Chesney", "Sam Hunt" ])
		
		let tournament3 = Tournament(tournamentID: "tempID", title: "Beatles Songs",  topic: "Music", author: "Justin", size: 64, description: "This is a test", optionTitlesList: ["Love Me Do", "The Long & Winding Road", "Tomorrow Never Knows", "Yellow Submarine", "I've Just Seen a Face", "Ob-La-Di Ob-La-Da", "Ticket to Ride", "While My Guitar Gently Weeps", "A Hard Day's Night", "Come Together", "Michelle", "Hello Goodbye", "Girl", "All You Need Is Love", "I Want To Hold Your Hand", "Something", "Twist & Shout", "Octupus's Garden", "Eleanor Rigby", "Sgt. Pepper's Lonely Heart's Club Band", "We Can Work It Out", "Revolution", "Eight Days A Week", "Helter Skelter", "I Feel Fine", "Get Back", "Drive My Car", "Hey Jude", "Taxman", "With A Little Help From My Friends", "From Me To You", "Here Comes The Sun", "Please Please Me", "Across The Universe", "Got to Get You Into My Life", "Strawberry Fields Forever", "Yesterday", "Dear Prudence", "You've Got to Hide Your Love Away", "Happiness Is a Warm Gun", "And I Love Her", "The Ballad of John & Yoko", "Nowhere Man", "I Am The Walrus", "In My Life", "A Day In The Life", "All My Loving", "Oh Darling", "I Saw Her Standing There", "Let It Be", "Here, There, and Everywhere", "Penny Lane", "Day Tripper", "Back In The USSR", "Help!", "Blackbird", "Can't Buy Me Love", "Don't Let Me Down", "Norwegian Wood", "Lady Madonna", "Paperback Writer", "Lucy In The Sky With Diamonds", "She Loves You", "Abbey Road Medley"])
		tempTitles.append(tournament1)
		tempTitles.append(tournament2)
		tempTitles.append(tournament3)
		
		
		
			
		
		var tempTopics: [TrendingTopic] = []
		let trendingTopic1 = TrendingTopic(topic: "Music", tournaments: tempTitles)
		tempTopics.append(trendingTopic1)
		
		trendingTopics = tempTopics
		print(trendingTopics.count + 1)
		
	}
	
	override func viewWillLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 130.0
		tableView.separatorColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
		
	}
	
	func setupNavBar() {
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return trendingTopics.count + 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Show Top Trending
		if indexPath.row < 1 {
			let cell = tableView.dequeueReusableCell(withIdentifier: TopTrendingTableViewCell.identifier, for: indexPath) as! TopTrendingTableViewCell
			cell.configure(with: topTrending)
			return cell
		}
		
		//Show topics
		let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as! TrendingTableViewCell
		print(indexPath.row)
		cell.configure(with: trendingTopics[indexPath.row - 1])
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row < 1 {
			return 160.0
		}
		return 150.0
	}
}
	

    


