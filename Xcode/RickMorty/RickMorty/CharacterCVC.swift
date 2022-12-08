//
//  CharacterCVC.swift
//  RickMorty
//
//  Created by Guest User on 08/12/2022.
//

import UIKit
import Alamofire

class CharacterCVC: UICollectionViewController, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
    private let cellName = "CharacterCollectionCell"
    private var characters : [RMCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView.prefetchDataSource = self
        let cellNib = UINib(nibName: cellName, bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellName)
        downloadAndParse()

        // Do any additional setup after loading the view.
    }
    
    private var isFetchInProgress = false
    private var apiUrl: String? = "https://rickandmortyapi.com/api/character"
    
    private func downloadAndParse() {
        //checking if we are already downloading and if we still have something to download
        guard isFetchInProgress == false && apiUrl != nil else {
            return
        }
        isFetchInProgress = true
        AF.request(apiUrl!)
            .validate()
            .responseDecodable(of: RMCharacterResponse.self) { response in
                switch response.result {
                case .success(let charResponse):
                    //append instead of replacing all the content
                    self.characters.append(contentsOf: charResponse.results)
                    self.apiUrl = charResponse.info.next
                    //smart reloading
                    self.reloadAfterFetching(newRowsCount: charResponse.results.count)
                case .failure(_):
                    return
                }
            }
    }
    
    private func reloadAfterFetching(newRowsCount: Int) {
        let isInitialFetch: Bool = newRowsCount == characters.count
        if isInitialFetch {
            self.collectionView.reloadData()
        }
        else {
            let startIndex = characters.count - newRowsCount
            let endIndex = startIndex + newRowsCount - 1
            let indexPathsToReload = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
            self.collectionView.insertItems(at: indexPathsToReload)
        }
        self.isFetchInProgress = false
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastItem: Int = characters.count - 1
        if (indexPaths.contains { $0.item == lastItem }) {
            downloadAndParse()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? CharacterCollectionCell else {
            fatalError("missing cell")
        }
        cell.displayChar(char: characters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let lastItem: Int = characters.count - 1
        if (indexPaths.contains { $0.item == lastItem }) {
            downloadAndParse()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CollectionDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            if segue.identifier == "CollectionDetailSegue" {
                if let destination = segue.destination as? CharacterDetailsVC {
                    destination.character = characters[indexPath.item]
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
