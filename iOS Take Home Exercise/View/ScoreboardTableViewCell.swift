//
//  ScoreboardTableViewCell.swift
//  iOS Take Home Exercise
//
//  Created by Shiv Kalola on 9/29/19.
//  Copyright © 2019 Lewanda, David. All rights reserved.
//

import UIKit

class ScoreboardTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "ScoreboardTableViewCell", bundle: nil)
    
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeRecord: UILabel!
    
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayRecord: UILabel!
    @IBOutlet weak var gameStatus: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
