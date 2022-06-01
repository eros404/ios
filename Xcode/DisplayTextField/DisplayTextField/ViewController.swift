//
//  ViewController.swift
//  DisplayTextField
//
//  Created by Utilisateur invité on 01/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testInput: UITextField!
    
    @IBAction func clearContent(_ sender: Any) {
        testInput.text = ""
        label.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var label: UILabel!
}

// MARK: - TextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        label.text = textField.text
        return true
    }
}
