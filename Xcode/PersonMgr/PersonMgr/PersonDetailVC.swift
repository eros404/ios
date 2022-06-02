//
//  PersonDetailVCViewController.swift
//  PersonMgr
//
//  Created by Utilisateur invité on 02/06/2022.
//

import UIKit

class PersonDetailVC: UIViewController {
    
    var person: Person? = nil

    @IBOutlet weak var fullNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let person = person {
            fullNameLabel.text = "\(person.firstName) \(person.lastName)"
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
