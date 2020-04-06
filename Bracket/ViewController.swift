//
//  ViewController.swift
//  Bracket
//
//  Created by Justin Galang on 3/11/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Status {
        	case win
            case lose
    }
    struct Option {
        var label : String
        var status : Status?
    }
    struct Node {
        var optionOne : Option
        var optionTwo : Option
        var round : Int
    }
    
    @IBOutlet weak var optionOneView: UIView!
    @IBOutlet weak var optionTwoView: UIView!

    @IBOutlet weak var optionOneLabel: UILabel!
    @IBOutlet weak var optionTwoLabel: UILabel!
    
    //for testing purposes
    @IBOutlet weak var resultOneTwoLabel: UILabel!

    
    var firstRound : [Node] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let disneyTitlesList =
            ["Lion King", "Tarzan", "Princess and The Frog", "Lilo and Stitch", "Tangled", "Big Hero 6", "Frozen", "Moana",  "Aladdin", "Hercules", "Little Mermaid","Pocahontas", "Mulan", "Zootopia", "Beauty and The Beast", "Nightmare Before Christmas", "UP",  "Brave", "Toy Story","Toy Story 2",  "Coco",  "Cars", "Toy Story 3", "The Good Dinosaur", "Ratatouille", "Bugs Life", "Nemo",  "Inside Out", "Monsters Inc.", "Cars 3", "Incredibles", "Wall-E"]
        
        //create options from titles
        var disneyOptionList : [Option] = []
        for title in disneyTitlesList {
            disneyOptionList.append(Option.init(label: title))
        }
        
        //create competitors
        for i in 0..<disneyOptionList.count/2 {
          firstRound.append(Node(optionOne: disneyOptionList[2*i], optionTwo: disneyOptionList[(2*i)+1], round: 0))
        }
        
        optionOneLabel.text = firstRound[0].optionOne.label
        optionTwoLabel.text = firstRound[0].optionTwo.label
        updateResults()
    }
    
    @IBAction func didTapOnOptionOne(_ sender: Any) {
        self.firstRound[0].optionOne.status = .win
        self.firstRound[0].optionTwo.status = .lose
        
        print("option one")
        updateResults()
    }
    
    @IBAction func didTapOnOptionTwo(_ sender: Any) {
        self.firstRound[0].optionTwo.status = .win
        self.firstRound[0].optionOne.status = .lose
        print("option two")
        updateResults()
    }
    
    func updateResults() {
        if firstRound[0].optionOne.status == .win {
            resultOneTwoLabel.text = firstRound[0].optionOne.label
        } else if firstRound[0].optionTwo.status == .win {
            resultOneTwoLabel.text = firstRound[0].optionTwo.label
        }
    }
    
