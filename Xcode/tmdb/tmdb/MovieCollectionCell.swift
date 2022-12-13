//
//  MovieCollectionCell.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import UIKit
import AlamofireImage

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var AverageScore: UILabel!
    @IBOutlet weak var Title: UILabel!
    func displayMovie(movie: TmdbMovie) {
        Title.text = movie.title
        AverageScore.text = "\(movie.vote_average.rounded(1, .bankers))"
        if let url = URL(string: "https://image.tmdb.org/t/p/w342\(movie.poster_path)") {
            Image.af.setImage(withURL: url)
        }
    }

}
