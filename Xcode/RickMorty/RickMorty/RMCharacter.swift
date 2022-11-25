//
//  RMCharacter.swift
//  RickMorty
//
//  Created by Guest User on 25/11/2022.
//

import Foundation

struct RMCharacter : Decodable {
    var id : Int
    var name : String
    var status : String
    var species : String
    var image : String
    var origin : RMOrigin
}
