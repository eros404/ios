//
//  TmdbMovieDetail.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import Foundation

struct TmdbMovieDetail : Decodable {
    var budget : Int
    var genres : [TmdbGenre]
}
