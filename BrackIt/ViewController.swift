//
//  ViewController.swift
//  Bracket
//
//  Created by Justin Galang on 3/11/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    
    var ref : DatabaseReference?
    var databaseHandle : DatabaseHandle?
    
    @IBOutlet weak var choicesView: UIView!
    
    @IBOutlet var tournamentView: UIView!
    @IBOutlet weak var choiceOneView: UIView!
    @IBOutlet weak var choiceTwoView: UIView!

    @IBOutlet weak var choiceOneLabel: UILabel!
    @IBOutlet weak var choiceTwoLabel: UILabel!
    
    //@IBOutlet weak var tournamentProgress: UIProgressView!
    
    var round : [[Node]] = []
    var currentRoundIndex = 0
    var currentNodeIndex = 0
    
    var optionList : [Option] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Screen Style
        tournamentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //Choice styles
        choiceOneView.layer.cornerRadius = 20.0
        choiceTwoView.layer.cornerRadius = 20.0
        //Choice View Colors updated in "updateChoices"
        //label style
        choiceOneLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        choiceOneLabel.layer.cornerRadius = 20.0
        choiceOneLabel.clipsToBounds = true
        choiceTwoLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        choiceTwoLabel.layer.cornerRadius = 20.0
        choiceTwoLabel.clipsToBounds = true
        
//        ref = Database.database().reference()
//        print("BEFORE HANDLE")
//        databaseHandle = (ref?.child("tournaments/categories/disney-pixar").observe(.value, with:{ (snapshot) in
//            let titleList = snapshot.value as? [String]
//            print("Test1)")
//            if let actualTitleList = titleList {
//                for title in actualTitleList {
//                    print(title)
//                    self.optionList.append(Option.init(label: title))
//                }
//            }
//        }))
//        print("Out")
//        let disneyTitleList = ["Lion King", "Tarzan", "Princess and The Frog", "Lilo and Stitch", "Tangled", "Big Hero 6", "Frozen", "Moana",  "Aladdin", "Hercules", "Little Mermaid","Pocahontas", "Mulan", "Zootopia", "Beauty and The Beast", "Nightmare Before Christmas", "UP",  "Brave", "Toy Story","Toy Story 2",  "Coco",  "Cars 2", "Toy Story 3", "The Good Dinosaur", "Ratatouille", "Bugs Life", "Nemo",  "Inside Out", "Monsters Inc.", "Cars", "Incredibles", "Wall-E"]
        
//        let titles = [ "Drag Me Down", "strong", "One Thing", "If I Could Fly", "Best Song Ever", "Midnight Memories", "Little Things", "What A Feeling", "Perfect", "Half A Heart", "No Control", "End of A Day", "You&I", "Stockholm Syndrome", "What Makes You Beautiful", "Rock Me", "Story of My Life", "More Than This", "They Don't Know About Us", "A.M", "Kiss You", "Where Do Broken Hearts Go", "Night Changes", "Olivia", "History", "Happily", "Live While You're Young", "18", "Infinity", "Love You Goodbye", "Steal My Girl", "Fireproof"]
//
//        let countryTitles = ["Luke Bryan", "Kelsea Ballerini", "Eric Church", "Zac Brown Band", "Tim McGraw", "Thomas Rhett", "Keith Urban", "Brett Eldredge", "Blake Shelton", "Little Big Town", "Miranda Lambert", "Florida Georgia Line", "Carrie Underwood", "Dierks Bentley", "Kenny Chesney", "Sam Hunt" ]
//
        
        let beatlesTitles = ["Love Me Do", "The Long & Winding Road", "Tomorrow Never Knows", "Yellow Submarine", "I've Just Seen a Face", "Ob-La-Di Ob-La-Da", "Ticket to Ride", "While My Guitar Gently Weeps", "A Hard Day's Night", "Come Together", "Michelle", "Hello Goodbye", "Girl", "All You Need Is Love", "I Want To Hold Your Hand", "Something", "Twist & Shout", "Octupus's Garden", "Eleanor Rigby", "Sgt. Pepper's Lonely Heart's Club Band", "We Can Work It Out", "Revolution", "Eight Days A Week", "Helter Skelter", "I Feel Fine", "Get Back", "Drive My Car", "Hey Jude", "Taxman", "With A Little Help From My Friends", "From Me To You", "Here Comes The Sun", "Please Please Me", "Across The Universe", "Got to Get You Into My Life", "Strawberry Fields Forever", "Yesterday", "Dear Prudence", "You've Got to Hide Your Love Away", "Happiness Is a Warm Gun", "And I Love Her", "The Ballad of John & Yoko", "Nowhere Man", "I Am The Walrus", "In My Life", "A Day In The Life", "All My Loving", "Oh Darling", "I Saw Her Standing There", "Let It Be", "Here, There, and Everywhere", "Penny Lane", "Day Tripper", "Back In The USSR", "Help!", "Blackbird", "Can't Buy Me Love", "Don't Let Me Down", "Norwegian Wood", "Lady Madonna", "Paperback Writer", "Lucy In The Sky With Diamonds", "She Loves You", "Abbey Road Medley"]
        
        // create options from titles
        var optionList : [Option] = []
        for title in beatlesTitles {
            optionList.append(Option.init(label: title))
        }
        
        //create competitor nodes from options
        var firstRound : [Node] = []
        for i in 0..<optionList.count/2 {
          firstRound.append(Node(optionOne: optionList[2*i], optionTwo: optionList[(2*i)+1], round: 1))
        } 
        round.append(firstRound)
        updateChoices()
    }
    
    @IBAction func didTapOnChoiceOne(_ sender: Any) {
        self.round[currentRoundIndex][currentNodeIndex].optionOne.status = .win
        self.round[currentRoundIndex][currentNodeIndex].optionTwo.status = .lose
        
        checkEnd()
    }
    
    @IBAction func didTapOnChoiceTwo(_ sender: Any) {
        self.round[currentRoundIndex][currentNodeIndex].optionTwo.status = .win
        self.round[currentRoundIndex][currentNodeIndex].optionOne.status = .lose
        
        checkEnd()
    }
    
    //checks if end of round -> Create new round
    //or if end of tournament -> display final
    func checkEnd(){
        
        //checks if all is complete
        var allComplete = false
        var unfinishedNodeIndex = 0
        for i in 0..<round[currentRoundIndex].count {
            if round[currentRoundIndex][i].optionOne.status == nil {
                unfinishedNodeIndex = i
                break
            } else {
                allComplete = true
            }
        }
        
        //if last node
        if currentNodeIndex == round[currentRoundIndex].count - 1 {
            //if complete
            if allComplete == true {
                //check if final choice node else, create new node
                if currentNodeIndex == 0 {
                    finalChoiceAction()
                } else {
                    createNextRound()
                    currentRoundIndex += 1
                    currentNodeIndex = 0
                    animateChoicesOut(direction: "forward")
                }
            } else {
                currentNodeIndex = unfinishedNodeIndex
                animateChoicesOut(direction: "prev")
            }
        } else {
            currentNodeIndex += 1
            animateChoicesOut(direction: "forward")
        }
    }

    //Swipe to previous choices
    @IBAction func didSwipeBack(_ sender: Any) {
        if currentNodeIndex != 0 {
            currentNodeIndex -= 1
        } else {
            return
        }
        animateChoicesOut(direction: "prev")
        print("back")
    }
    
    //Swipe to next choices
    @IBAction func didSwipeForward(_ sender: Any) {
        if currentNodeIndex != round[currentRoundIndex].count - 1 {
            currentNodeIndex += 1
        } else {
            return
        }
        animateChoicesOut(direction: "forward")
        print("forward")
    }
    
    //animation for swiping back
    func animateChoicesOut(direction: String) {
        var translateDist = -530
        //change direction
        if direction == "prev" {
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
        if direction == "prev" {
            translateDist *= -1
        }
        
        choicesView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: CGFloat(translateDist))
        
        UIView.animate(withDuration: 0.3, animations: {
            self.choicesView.transform = CGAffineTransform.identity
        })
    }
    
    //update Choice Views and Labels
    func updateChoices() {
        choiceOneLabel.text = round[currentRoundIndex][currentNodeIndex].optionOne.label
        choiceTwoLabel.text = round[currentRoundIndex][currentNodeIndex].optionTwo.label
        
        if round[currentRoundIndex][currentNodeIndex].optionOne.status != nil && round[currentRoundIndex][currentNodeIndex].optionTwo.status != nil {
            if round[currentRoundIndex][currentNodeIndex].optionOne.status == .win {
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
                
            } else if round[currentRoundIndex][currentNodeIndex].optionTwo.status == .win {
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
        } else {
            choiceOneLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            choiceOneLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            choiceOneView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            choiceOneView.layer.borderWidth = 3.0
            
            choiceTwoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            choiceTwoLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            choiceTwoView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            choiceTwoView.layer.borderWidth = 3.0
        }
    }
    
    func createNextRound() {
        //get winning titles
        var winningTitles : [String] = []
        for node in round[currentRoundIndex] {
            if node.optionOne.status == .win {
                winningTitles.append(node.optionOne.label)
            } else if node.optionTwo.status == .win {
                winningTitles.append(node.optionTwo.label)
            }
        }
        //create options from titles
        var winningOptions : [Option] = []
        for title in winningTitles {
            winningOptions.append(Option.init(label: title))
        }
        //make NEW competitor node list of winning options
        var winners : [Node] = []
        for i in 0..<winningTitles.count/2 {
            winners.append(Node(optionOne: winningOptions[2*i], optionTwo: winningOptions[(2*i)+1], round: round[currentRoundIndex].count + 1))
        }
        
        for node in winners {
            print("\(node.optionOne.label), \(node.optionTwo.label)")
        }
        //add round to list
        round.append(winners)
    }
    func finalChoiceAction(){
    
    }
}
