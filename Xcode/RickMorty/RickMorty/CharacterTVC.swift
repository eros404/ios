//
//  CharacterTVC.swift
//  RickMorty
//
//  Created by Guest User on 25/11/2022.
//

import UIKit
import Alamofire

class CharacterTVC: UITableViewController, UITableViewDataSourcePrefetching {
    
    private let cellName = "CharacterCell"
    private var characters : [RMCharacter] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.prefetchDataSource = self
        let cellNib = UINib(nibName: cellName, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: cellName)
        downloadAndParse()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? CharacterCell else {
            fatalError("missing cell")
        }
        cell.displayChar(char: characters[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if segue.identifier == "DetailSegue" {
                if let destination = segue.destination as? CharacterDetailsVC {
                    destination.character = characters[indexPath.item]
                }
            }
        }
    }
    
    private func reloadAfterFetching(newRowsCount: Int) {
        let isInitialFetch: Bool = newRowsCount == characters.count
        if isInitialFetch {
            self.tableView.reloadData()
        }
        else {
            let startIndex = characters.count - newRowsCount
            let endIndex = startIndex + newRowsCount - 1
            let indexPathsToReload = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
            self.tableView.insertRows(at: indexPathsToReload, with: .automatic)
        }
        self.isFetchInProgress = false
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastItem: Int = characters.count - 1
        if (indexPaths.contains { $0.item == lastItem }) {
            downloadAndParse()
        }
    }
}
