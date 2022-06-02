//
//  Game.swift
//  GameCritic
//
//  Created by Utilisateur invité on 02/06/2022.
//

import Foundation

class Game : Decodable {
    var id: Int
    var name: String
    var smallImageURL: String
    var bigImageURL: String
    var score: Int
    var platform: String
    
    init(id: Int, name: String, smallImageURL: String, bigImageURL: String, score: Int, platform: String) {
        self.id = id
        self.name = name
        self.smallImageURL = smallImageURL
        self.bigImageURL = bigImageURL
        self.score = score
        self.platform = platform
    }
    
    static func fakeGame(id: Int) -> Game {
        return Game(id: id, name: "COD \(Int.random(in: 1...1000))", smallImageURL: "", bigImageURL: "", score: Int.random(in: 0...10), platform: "ps\(Int.random(in: 1...5))")
    }
}
