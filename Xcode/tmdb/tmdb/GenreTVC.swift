//
//  GenreTVC.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import UIKit
import Alamofire

class GenreTVC: UITableViewController {
    
    private var genres : [TmdbGenre] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadAndParse()
    }

    // MARK: - Table view data source
    
    private func downloadAndParse() {
        AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=2fda3ebbed4a3f25138ca9d08d34ece0")
            .validate()
            .responseDecodable(of: TmdbGenreResponse.self) { response in
                switch response.result {
                case .success(let genreResponse):
                    self.genres = genreResponse.genres
                    self.tableView.reloadData()
                case .failure(_):
                    return
                }
            }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        content.text = genres[indexPath.item].name
        cell.contentConfiguration = content

        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "toMovieListSegue" {
                if let destination = segue.destination as? MovieCVC {
                    destination.genre = genres[indexPath.item]
                }
            }
        }
    }

}
