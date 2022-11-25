//
//  CharacterDetailsVC.swift
//  RickMorty
//
//  Created by Guest User on 25/11/2022.
//

import UIKit
import AlamofireImage

class CharacterDetailsVC: UIViewController {
    
    var character: RMCharacter? = nil

    @IBOutlet weak var CharacterImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let character = self.character {
            if let url = URL(string: character.image) {
                CharacterImage.af.setImage(withURL: url)
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
