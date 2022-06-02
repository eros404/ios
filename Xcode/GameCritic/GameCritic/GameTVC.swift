//
//  GameTVC.swift
//  GameCritic
//
//  Created by Utilisateur invité on 02/06/2022.
//

import UIKit

class GameTVC: UITableViewController {
    
    var groupedGames: [String : [Game]] = [:]
    var allPlatforms: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.getGames()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedGames.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedGames[allPlatforms[section]]?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        let game = groupedGames[allPlatforms[indexPath.section]]?[indexPath.item]
        if let game = game {
            cell.textLabel?.text = game.name
            let data = try? Data.init(contentsOf: URL(string: game.smallImageURL)!)
            if let data = data {
                cell.imageView?.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func download(at url: String, handler: @escaping (Data?) -> Void) {
        // 1 - Create URL
        guard let url = URL(string: url) else {
            debugPrint("Failed to create URL")
            handler(nil)
            return
        }
        // 2 - Create GET Request
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        // 3 - Create download task, handler will be called when request ended
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            handler(data)
        }
        task.resume()
    }
    
    func getGames() {
        download(at: "https://education.3ie.fr/ios/StarterKit/GameCritic/GameCritics.json") { (gameData) in
            if let gameData = gameData {
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    let games = try decoder.decode([Game].self, from: gameData)
                    self.groupedGames = Dictionary(grouping: games, by: { $0.platform })
                    self.allPlatforms = Array(self.groupedGames.keys)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch {
                    debugPrint("Failed to parse data")
                }
            }
            else {
                debugPrint("Failed to get games data")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allPlatforms[section]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            guard let detailVC = segue.destination as? GameDetailVC else {
                return
            }
            //1st: get your person from your array based on your indexPath
            //2nd: give this person to your personDetailVC
            detailVC.game = groupedGames[allPlatforms[indexPath.section]]?[indexPath.item]
        }
    }
}
