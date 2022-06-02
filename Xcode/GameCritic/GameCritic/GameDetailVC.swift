//
//  GameDetailVC.swift
//  GameCritic
//
//  Created by Utilisateur invité on 02/06/2022.
//

import UIKit

class GameDetailVC: UIViewController {
    
    var game: Game? = nil

    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let game = game {
            gameName.text = game.name
            let data = try? Data.init(contentsOf: URL(string: game.bigImageURL)!)
            if let data = data {
                gameImage.image = UIImage(data: data)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
