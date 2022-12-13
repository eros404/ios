//
//  TmdbDiscoverMovieResponse.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import Foundation

struct TmdbDiscoverMovieResponse : Decodable {
    var page : Int
    var total_pages : Int
    var results : [TmdbMovie]
}
