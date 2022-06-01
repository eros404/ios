//
//  ViewController.swift
//  NameChecker
//
//  Created by Utilisateur invité on 01/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loader.isHidden = true
    }

    @IBOutlet weak var compatibilityLabel: UILabel!
    
    @IBOutlet weak var firstPersonInput: UITextField!
    @IBOutlet weak var secondPersonInput: UITextField!
    @IBAction func checkCompatibility(_ sender: Any) {
        if let name1 = firstPersonInput.text, let name2 = secondPersonInput.text, firstPersonInput.text != "", secondPersonInput.text != "" {
            loader.isHidden = false
            compatibilityLabel.text = "Thinking..."
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let nameDistance = abs(name1.count - name2.count)
                let biggestLength = max(name1.count, name2.count)
                let iCompatibility: Int = 100 - Int((Double(nameDistance) / Double(biggestLength)) * 100)
                self.loader.isHidden = true
                self.compatibilityLabel.text = "Compatibility: \(iCompatibility)%"
            }
        }
    }
}

// MARK: - TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
