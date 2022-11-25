//
//  RMCharacterResponse.swift
//  RickMorty
//
//  Created by Guest User on 25/11/2022.
//

import Foundation

struct RMCharacterResponse: Decodable {
    var results: [RMCharacter]
}
