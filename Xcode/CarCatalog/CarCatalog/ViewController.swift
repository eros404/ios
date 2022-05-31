//
//  ViewController.swift
//  CarCatalog
//
//  Created by Utilisateur invité on 31/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var cars: [Car] = []

    @IBOutlet weak var carsTextArea: UITextView!
    
    @IBAction func addTenCars(_ sender: Any) {
        for _ in 1...10 {
            cars.append(Car.makeRandomCar())
        }
        displayCars()
    }
    
    @IBAction func clearCars(_ sender: Any) {
        cars.removeAll()
        displayCars()
    }
    
    private func displayCars() {
        carsTextArea.text = ""
        for car in self.cars {
            carsTextArea.text = carsTextArea.text + "\n" + car.description
        }
        if cars.count == 0 {
            carsTextArea.text = "No data"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

