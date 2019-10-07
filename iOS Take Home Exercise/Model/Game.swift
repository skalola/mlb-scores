//
//  Game.swift
//  iOS Take Home Exercise
//
//  Created by Shiv Kalola on 9/29/19.
//  Copyright © 2019 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

struct Game {
    let homeTeamName: String
    let homeTeamScore: Int
    let homeTeamWins: Int
    let homeTeamLosses: Int
    let homeTeamHits: Int
    let homeTeamErrors: Int
    let awayTeamName: String
    let awayTeamScore: Int
    let awayTeamWins: Int
    let awayTeamLosses: Int
    let awayTeamHits: Int
    let awayTeamErrors: Int
    let gameStatus: String
    let currentInning: Int
    let currentInningOrdinal: String
    let inningState: String
    let gameDate: String
    let gameVenue: String
    
    init(homeTeamName: String, homeTeamScore: Int, homeTeamWins: Int, homeTeamLosses: Int, homeTeamHits: Int, homeTeamErrors: Int, awayTeamName: String, awayTeamScore: Int, awayTeamWins: Int, awayTeamLosses: Int, awayTeamHits: Int, awayTeamErrors: Int, gameStatus: String, currentInning: Int, currentInningOrdinal: String, inningState: String, gameDate: String, gameVenue: String) {
        self.homeTeamName = homeTeamName
        self.homeTeamScore = homeTeamScore
        self.homeTeamWins = homeTeamWins
        self.homeTeamLosses = homeTeamLosses
        self.homeTeamHits = homeTeamHits
        self.homeTeamErrors = homeTeamErrors
        self.awayTeamName = awayTeamName
        self.awayTeamScore = awayTeamScore
        self.awayTeamWins = awayTeamWins
        self.awayTeamLosses = awayTeamLosses
        self.awayTeamHits = awayTeamHits
        self.awayTeamErrors = awayTeamErrors
        self.gameStatus = gameStatus
        self.currentInning = currentInning
        self.currentInningOrdinal = currentInningOrdinal
        self.inningState = inningState
        self.gameDate = gameDate
        self.gameVenue = gameVenue
    }
    
}
