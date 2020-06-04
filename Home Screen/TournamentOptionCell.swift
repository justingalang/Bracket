//
//  TournamentOptionCell.swift
//  BrackIt
//
//  Created by Justin Galang on 5/5/20.
//  Copyright © 2020 Justin Galang. All rights reserved.
//

import UIKit

class TournamentOptionCell: UITableViewCell {
		@IBOutlet weak var tournamentTitle: UILabel!
		@IBOutlet weak var tournamentAuthor: UILabel!
		
		func setTournament(tournament: Tournament) {
			tournamentTitle.text = tournament.title
			tournamentAuthor.text = tournament.author
			
		}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
