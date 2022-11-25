//
//  CharacterCell.swift
//  RickMorty
//
//  Created by Guest User on 25/11/2022.
//

import UIKit
import AlamofireImage

class CharacterCell: UITableViewCell {

    @IBOutlet weak var CharacterImage: UIImageView!
    @IBOutlet weak var CharacterSpecies: UILabel!
    @IBOutlet weak var CharacterOrigin: UILabel!
    @IBOutlet weak var CharacterName: UILabel!
    func displayChar(char: RMCharacter) {
        CharacterName.text = char.name
        CharacterOrigin.text = char.origin.name
        CharacterSpecies.text = char.species
        if let url = URL(string: char.image) {
            CharacterImage.af.setImage(withURL: url)
        }
    }
}
