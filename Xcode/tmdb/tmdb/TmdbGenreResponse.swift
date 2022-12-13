//
//  TmdbGenreResponse.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import Foundation

struct TmdbGenreResponse : Decodable {
    var genres : [TmdbGenre]
}
