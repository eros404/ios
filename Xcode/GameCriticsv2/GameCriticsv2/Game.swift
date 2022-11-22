//
//  Game.swift
//  GameCriticsv2
//
//  Created by Guest User on 22/11/2022.
//

import Foundation

struct Game : Decodable {
    var id: Int
    var name: String
    var smallImageURL: String
    var bigImageURL: String
    var score: Int
    var platform: String
}
