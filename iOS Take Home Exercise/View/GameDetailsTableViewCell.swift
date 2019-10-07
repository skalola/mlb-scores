//
//  GameDetailsTableViewCell.swift
//  iOS Take Home Exercise
//
//  Created by Shiv Kalola on 9/29/19.
//  Copyright © 2019 Lewanda, David. All rights reserved.
//

import UIKit

class GameDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamRuns: UILabel!
    @IBOutlet weak var awayTeamHits: UILabel!
    @IBOutlet weak var awayTeamErrors: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamRuns: UILabel!
    @IBOutlet weak var homeTeamHits: UILabel!
    @IBOutlet weak var homeTeamErrors: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var awayTeamBoxName: UILabel!
    @IBOutlet weak var homeTeamBoxName: UILabel!
    
    
    static let nib = UINib(nibName: "GameDetailsTableViewCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
