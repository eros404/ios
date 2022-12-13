//
//  MoveDetailVC.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import UIKit
import AlamofireImage
import Alamofire

class MovieDetailVC: UIViewController {

    var movie : TmdbMovie? = nil
    
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MovieVoteCount: UILabel!
    @IBOutlet weak var MovieAverageScore: UILabel!
    @IBOutlet weak var MovieOverview: UILabel!
    @IBOutlet weak var MoviePoster: UIImageView!
    @IBOutlet weak var MovieBudget: UILabel!
    @IBOutlet weak var MovieGenres: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movie = movie {
            MovieTitle.text = movie.title
            MovieOverview.text = movie.overview
            MovieAverageScore.text = "\(movie.vote_average.rounded(1, .bankers))"
            MovieVoteCount.text = "with \(movie.vote_count) votes"
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") {
                MoviePoster.af.setImage(withURL: url)
            }
            downloadAndDisplayDetails()
        }
    }
    
    private func downloadAndDisplayDetails() {
        AF.request("https://api.themoviedb.org/3/movie/\(movie!.id)?api_key=2fda3ebbed4a3f25138ca9d08d34ece0")
            .validate()
            .responseDecodable(of: TmdbMovieDetail.self) { response in
                switch response.result {
                case .success(let detailResponse):
                    self.MovieBudget.text = detailResponse.budget != 0 ? "Budget: \(detailResponse.budget)" : "Budget: unknown"
                    self.MovieGenres.text = detailResponse.genres.map{ $0.name }.joined(separator: " / ")
                case .failure(_):
                    return
                }
            }
    }
}
