//
//  CharacterCollectionCell.swift
//  RickMorty
//
//  Created by Guest User on 08/12/2022.
//

import UIKit
import AlamofireImage

class CharacterCollectionCell: UICollectionViewCell {

    @IBOutlet weak var CharacterName: UILabel!
    @IBOutlet weak var CharacterImage: UIImageView!
    func displayChar(char: RMCharacter) {
        CharacterName.text = char.name
        if let url = URL(string: char.image) {
            CharacterImage.af.setImage(withURL: url)
        }
    }
}
