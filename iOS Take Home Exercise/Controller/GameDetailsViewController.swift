//
//  GameDetailsViewController.swift
//  iOS Take Home Exercise
//
//  Created by Shiv Kalola on 9/29/19.
//  Copyright © 2019 Lewanda, David. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GameDetailsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var awayTeamName: String?
    var awayTeamRuns: Int?
    var awayTeamHits: Int?
    var awayTeamErrors: Int?
    var homeTeamName: String?
    var homeTeamRuns: Int?
    var homeTeamHits: Int?
    var homeTeamErrors: Int?
    var venue: String?
    var gameStatus: String?
    
    override func viewDidLoad() {
        // Set mlb header logo
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "mlb-logo")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
        // Register ScoreboardTableVieCell
        tableView.register(GameDetailsTableViewCell.nib,
        forCellReuseIdentifier: "GameDetailsTableViewCell")

    }
}

// MARK: - UITableViewDataSource
extension GameDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailsTableViewCell",
                                                 for: indexPath) as! GameDetailsTableViewCell
        
        // Populate cells with game details data from ScoreboardViewController indexPath
        cell.awayTeamName?.text = awayTeamName
        cell.awayTeamLogo?.image = UIImage(named: "\(awayTeamName!)")
        cell.awayTeamRuns?.text = "\(awayTeamRuns!)"
        cell.awayTeamHits?.text = "\(awayTeamHits!)"
        cell.awayTeamErrors?.text = "\(awayTeamErrors!)"
        cell.homeTeamName?.text = homeTeamName
        cell.homeTeamLogo?.image = UIImage(named: "\(homeTeamName!)")
        cell.homeTeamRuns?.text = "\(homeTeamRuns!)"
        cell.homeTeamHits?.text = "\(homeTeamHits!)"
        cell.homeTeamErrors?.text = "\(homeTeamErrors!)"
        cell.scoreLabel?.text = "\(awayTeamRuns!) - \(homeTeamRuns!) "
        cell.venueLabel?.text = venue
        cell.awayTeamBoxName?.text = awayTeamName
        cell.homeTeamBoxName?.text = homeTeamName
        
        return cell
        
    }
}

