//
//  MovieCVC.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class MovieCVC: UICollectionViewController, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
    
    private let cellName = "MovieCollectionCell"
    var genre : TmdbGenre? = nil
    private var movies : [TmdbMovie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView.prefetchDataSource = self
        let cellNib = UINib(nibName: cellName, bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellName)

        // Do any additional setup after loading the view.
        downloadAndParse()
    }
    
    private var isFetchInProgress = false
    private var apiUrl: String? = "https://api.themoviedb.org/3/discover/movie?api_key=2fda3ebbed4a3f25138ca9d08d34ece0"
    private var currentPage = 1
    
    private func downloadAndParse() {
        //checking if we are already downloading and if we still have something to download
        guard isFetchInProgress == false && apiUrl != nil else {
            return
        }
        isFetchInProgress = true
        AF.request("\(apiUrl!)&with_genres=\(genre?.id ?? 1)&page=\(currentPage)")
            .validate()
            .responseDecodable(of: TmdbDiscoverMovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    //append instead of replacing all the content
                    self.movies.append(contentsOf: movieResponse.results)
                    if (self.currentPage == movieResponse.total_pages) {
                        self.apiUrl = nil
                    } else {
                        self.currentPage += 1
                    }
                    //smart reloading
                    self.reloadAfterFetching(newRowsCount: movieResponse.results.count)
                case .failure(_):
                    return
                }
            }
    }
    
    private func reloadAfterFetching(newRowsCount: Int) {
        let isInitialFetch: Bool = newRowsCount == movies.count
        if isInitialFetch {
            self.collectionView.reloadData()
        }
        else {
            let startIndex = movies.count - newRowsCount
            let endIndex = startIndex + newRowsCount - 1
            let indexPathsToReload = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
            self.collectionView.insertItems(at: indexPathsToReload)
        }
        self.isFetchInProgress = false
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let lastItem: Int = movies.count - 1
        if (indexPaths.contains { $0.item == lastItem }) {
            downloadAndParse()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? MovieCollectionCell else {
            fatalError("missing cell")
        }
        cell.displayMovie(movie: movies[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMovieDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            if segue.identifier == "toMovieDetailSegue" {
                if let destination = segue.destination as? MovieDetailVC {
                    destination.movie = movies[indexPath.item]
                }
            }
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.collectionViewLayout.invalidateLayout()
    }
    
    private let itemsPerRow: CGFloat = 2
    private let lineSpacing: CGFloat = 12
    private let itemSpacing: CGFloat = 12
    private let sectionInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = itemSpacing * (itemsPerRow - 1) + sectionInsets.left + sectionInsets.right
        let availableWidth = view.frame.width - paddingSpace
        let width = (availableWidth / itemsPerRow).rounded(.towardZero)
        let height = (width * 2.0 / 3.0).rounded(.towardZero)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
}
