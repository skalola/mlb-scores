//
//  ScoreboardViewController.swift
//  iOS Take Home Exercise
//
//  Created by Lewanda, David on 1/25/19.
//  Copyright © 2019 Lewanda, David. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ScoreboardViewController: UIViewController {
        
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var previousDateButton: UIButton!
    @IBOutlet weak var nextDateButton: UIButton!
    
    let today = Date()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var dateComponents = DateComponents()
    var calendar = Calendar.current
    var finalGameURL = ""
    let favoriteTeam = "Mets"
    var gamesList = [Game]()
    var convertedTime: String = ""
    
    // Set current day
       var date: String? {
           didSet {
               dateLabel.text = date
           }
       }
    
    // Go to previous date
    func yesterday() -> Date {
        dateComponents.setValue(-1, for: .day) // -1 day
        dateFormatter.dateFormat = "EEEE MMMM d yyyy"
        let date = dateFormatter.date(from: dateLabel.text!)
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: date!)
        return yesterday!
    }
    
    // Go to next date
    func tomorrow() -> Date {
        dateComponents.setValue(1, for: .day); // +1 day
        dateFormatter.dateFormat = "EEEE MMMM d yyyy"
        let date = dateFormatter.date(from: dateLabel.text!)
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: date!)
        return tomorrow!
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        let currentDay = yesterday()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let apiDate = dateFormatter.string(from: currentDay)
        dateLabel.text = dateFormatter.string(from: currentDay)

        // Make API call with selected date
        finalGameURL = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=\(apiDate)&sportId=1,51&language=en"
         
        getMLBGameListData(url: finalGameURL)
        gamesList.removeAll()
        self.tableView.reloadData()
        
         // Pass parameter for date to stylize date label
        stylizeDate(getDate: currentDay)
      
     }
     
     @IBAction func nextButtonTapped(_ sender: Any) {
        let currentDay = tomorrow()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let apiDate = dateFormatter.string(from: currentDay)
         dateLabel.text = dateFormatter.string(from: currentDay)
                 
        // Make API call with selected date
        finalGameURL = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=\(apiDate)&sportId=1,51&language=en"
         
        getMLBGameListData(url: finalGameURL)
        gamesList.removeAll()
        self.tableView.reloadData()

         // Pass parameter for date to stylize date label
        stylizeDate(getDate: currentDay)

     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set mlb header logo
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "mlb-logo")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
        // Register ScoreboardTableVieCell
        tableView.register(ScoreboardTableViewCell.nib,
        forCellReuseIdentifier: "ScoreboardTableViewCell")
        
        // Set today's date and make API call for current games
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let apiDate = dateFormatter.string(from: today)
        dateLabel.text = date
        stylizeDate(getDate: today)
        
        // Make API call with selected date
        finalGameURL = "https://statsapi.mlb.com/api/v1/schedule?hydrate=team(league),venue(location,timezone),linescore&date=\(apiDate)&sportId=1,51&language=en"
        
        getMLBGameListData(url: finalGameURL)
        self.tableView.reloadData()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Networking
        func getMLBGameListData(url: String) {
           // Return game data
           Alamofire.request(url, method: .get)
                .responseJSON { response in
                    if response.result.isSuccess {
                       let resultValue = response.result.value ?? ""
                       let resultJSON = JSON(resultValue)
                       let gamesJSON = resultJSON["dates"][0]["games"]
                        if gamesJSON != JSON.null {
                            self.updateGameData(gamesJSON: gamesJSON)
                        }
                    }
                }
        }
        
        // MARK: - JSON Parsing
        func updateGameData(gamesJSON: JSON) {
            
            for (_, gameJSON) in gamesJSON {
                //Home Team Data
                let homeTeamName = gameJSON["teams"]["home"]["team"]["teamName"].stringValue
                let homeTeamScore = gameJSON["teams"]["home"]["score"].intValue
                let homeTeamWins = gameJSON["teams"]["home"]["leagueRecord"]["wins"].intValue
                let homeTeamLosses = gameJSON["teams"]["home"]["leagueRecord"]["losses"].intValue
                let homeTeamHits = gameJSON["linescore"]["teams"]["home"]["hits"].intValue
                let homeTeamErrors = gameJSON["linescore"]["teams"]["home"]["errors"].intValue
                
                //Away Team Data
                let awayTeamName = gameJSON["teams"]["away"]["team"]["teamName"].stringValue
                let awayTeamScore = gameJSON["teams"]["away"]["score"].intValue
                let awayTeamWins = gameJSON["teams"]["away"]["leagueRecord"]["wins"].intValue
                let awayTeamLosses = gameJSON["teams"]["away"]["leagueRecord"]["losses"].intValue
                let awayTeamHits = gameJSON["linescore"]["teams"]["away"]["hits"].intValue
                let awayTeamErrors = gameJSON["linescore"]["teams"]["away"]["errors"].intValue
                
                //Game Data
                let gameStatus = gameJSON["status"]["detailedState"].stringValue
                let currentInning = gameJSON["linescore"]["currentInning"].intValue
                let currentInningOrdinal = gameJSON["linescore"]["currentInningOrdinal"].stringValue
                let inningState = gameJSON["linescore"]["inningState"].stringValue
                let gameDate = gameJSON["gameDate"].stringValue
                let gameVenue = gameJSON["venue"]["name"].stringValue

                let game = Game(homeTeamName: homeTeamName, homeTeamScore: homeTeamScore, homeTeamWins: homeTeamWins, homeTeamLosses: homeTeamLosses, homeTeamHits: homeTeamHits, homeTeamErrors: homeTeamErrors, awayTeamName: awayTeamName, awayTeamScore: awayTeamScore, awayTeamWins: awayTeamWins, awayTeamLosses: awayTeamLosses, awayTeamHits: awayTeamHits, awayTeamErrors: awayTeamErrors, gameStatus: gameStatus, currentInning: currentInning, currentInningOrdinal: currentInningOrdinal, inningState: inningState, gameDate: gameDate, gameVenue: gameVenue)
                
                gamesList.append(game)

            }
            self.tableView.reloadData()
        }
    
}

// MARK: - UITableViewDataSource
extension ScoreboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreboardTableViewCell",
                                                 for: indexPath) as! ScoreboardTableViewCell
        
        let game = gamesList[indexPath.row]
        cell.homeTeamName?.text = game.homeTeamName
        cell.homeTeamName?.font = UIFont.systemFont(ofSize: 15)
        cell.homeTeamScore?.text = "\(game.homeTeamScore)"
        cell.homeTeamLogo?.image = UIImage(named: "\(game.homeTeamName)")
        cell.homeRecord?.text = "(\(game.homeTeamWins) - \(game.homeTeamLosses))"

        cell.awayTeamName?.text = game.awayTeamName
        cell.awayTeamName?.font = UIFont.systemFont(ofSize: 15)
        cell.awayTeamScore?.text = "\(game.awayTeamScore)"
        cell.awayTeamLogo?.image = UIImage(named: "\(game.awayTeamName)")
        cell.awayRecord?.text = "(\(game.awayTeamWins) - \(game.awayTeamLosses))"
        
        // Hide scores
        if game.gameStatus == "Scheduled" {
            cell.homeTeamScore?.isHidden = true
            cell.awayTeamScore?.isHidden = true
        }
        if game.gameStatus == "Cancelled" {
            cell.homeTeamScore?.isHidden = true
            cell.awayTeamScore?.isHidden = true
        }
        if game.gameStatus == "Postponed" {
            cell.homeTeamScore?.isHidden = true
            cell.awayTeamScore?.isHidden = true
        }
        if game.gameStatus == "Final" {
            cell.homeTeamScore?.isHidden = false
            cell.awayTeamScore?.isHidden = false
        }
        
        // Show game time for scheduled games and sort list        
        if game.gameStatus == "Final" {
            if game.currentInning != 9 {
                // Show "F/#" for games ended early or extra innings
                cell.gameStatus?.text = "F/\(game.currentInning)"
            } else {
                // Show "Final" for finished games
                cell.gameStatus?.text = game.gameStatus
            }
            // bold the winning team for current game row
            if game.homeTeamScore > game.awayTeamScore {
                cell.homeTeamName?.font = UIFont.boldSystemFont(ofSize: 15)
            } else if game.awayTeamScore > game.homeTeamScore {
                cell.awayTeamName?.font = UIFont.boldSystemFont(ofSize: 15)
            }
        } else if game.gameStatus == "In Progress" {
            // Show "current inning" for games in progress
            let formatter = NumberFormatter()
            formatter.numberStyle = .ordinal
            cell.gameStatus?.text = "\(game.inningState) of \(game.currentInningOrdinal)"
        } else if game.gameStatus == "Postponed" {
            // Show "Postponed" for games that were delayed
            cell.gameStatus?.text = game.gameStatus
        } else if game.gameStatus == "Cancelled"{
            // Show "Cnancelled" for games that were cancelled
            cell.gameStatus?.text = game.gameStatus
        } else {
            // Show "Game time" for scheduled games
            timeFormatter.dateFormat = "yyyy-MM-dd'T'H:mm:ssZ"
            let time = timeFormatter.date(from: game.gameDate)
            timeFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
            timeFormatter.dateFormat = "h:mm a"
            let Time12 = timeFormatter.string(from: time!)
            cell.gameStatus?.text = Time12
        }
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate
extension ScoreboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = gamesList[indexPath.row]
        let awayTeamName = selectedGame.awayTeamName
        let awayTeamRuns = selectedGame.awayTeamScore
        let awayTeamHits = selectedGame.awayTeamHits
        let awayTeamErrors = selectedGame.awayTeamErrors
        let homeTeamName = selectedGame.homeTeamName
        let homeTeamRuns = selectedGame.homeTeamScore
        let homeTeamHits = selectedGame.homeTeamHits
        let homeTeamErrors = selectedGame.homeTeamErrors
        let venue = selectedGame.gameVenue
        let gameStatus = selectedGame.gameStatus
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "GameDetailsViewController") as? GameDetailsViewController {
            
            vc.awayTeamName = awayTeamName
            vc.awayTeamRuns = awayTeamRuns
            vc.awayTeamHits = awayTeamHits
            vc.awayTeamErrors = awayTeamErrors
            vc.homeTeamName = homeTeamName
            vc.homeTeamRuns = homeTeamRuns
            vc.homeTeamHits = homeTeamHits
            vc.homeTeamErrors = homeTeamErrors
            vc.venue = venue
            vc.gameStatus = gameStatus
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ScoreboardViewController {
    // Bold month/day and hide year from view with parameter for date
       func stylizeDate(getDate: Date) -> Date {
           let components = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: getDate)
           let year = components.year!
           let day = components.day!
           let weekday = components.weekday!
           let weekdayName = Calendar.current.weekdaySymbols[weekday-1]
           let month = components.month!
           let monthName = Calendar.current.monthSymbols[month-1]

           let boldAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!
           ]
           let regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 15.0)!
           ]
           let hiddenAttribute = [
               NSAttributedString.Key.foregroundColor: UIColor(red: 0.0471, green: 0.0392, blue: 0.0392, alpha: 0.0)
           ]
           let boldText = NSAttributedString(string: "\(monthName) \(day) ", attributes: boldAttribute)
           let regularText = NSAttributedString(string: "\(weekdayName) ", attributes: regularAttribute)
           let invisibleText = NSAttributedString(string: "\(year)", attributes: hiddenAttribute)
           let newString = NSMutableAttributedString()
           newString.append(regularText)
           newString.append(boldText)
           newString.append(invisibleText)

           dateLabel.attributedText = newString
           
           return getDate
       }

}
