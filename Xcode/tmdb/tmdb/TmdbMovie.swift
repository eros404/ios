//
//  TmdbMovie.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import Foundation

struct TmdbMovie : Decodable {
    var id : Int
    var title : String
    var vote_average : Decimal
    var poster_path : String
    var vote_count : Int
    var overview : String
}
