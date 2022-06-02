//
//  PersonDetailVCViewController.swift
//  PersonMgr
//
//  Created by Utilisateur invité on 02/06/2022.
//

import UIKit

class PersonDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var person: Person? = nil

    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var nationalityInput: UITextField!
    @IBOutlet weak var birthYearPicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    var birthYearData: [String] = []
    var genderData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.birthYearPicker.delegate = self
        self.birthYearPicker.dataSource = self
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        
        let currentYear: Int = Calendar.current.component(.year, from: Date())
        for i in 1900...currentYear {
            birthYearData.append("\(i)")
        }
        genderData = ["Male", "Female", "Other"]
        
        if let person = person {
            lastNameInput.text = person.lastName
            firstNameInput.text = person.firstName
            nationalityInput.text = person.nationality
            birthYearPicker.selectRow(birthYearData.firstIndex(of: "\(person.birthYear)") ?? 0, inComponent: 0, animated: false)
            genderPicker.selectRow(genderData.firstIndex(of: person.gender) ?? 0, inComponent: 0, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let person = person {
            person.lastName = lastNameInput.text ?? ""
            person.firstName = firstNameInput.text ?? ""
            person.nationality = nationalityInput.text ?? ""
            person.birthYear = Int(birthYearData[birthYearPicker.selectedRow(inComponent: 0)]) ?? Calendar.current.component(.year, from: Date())
            person.gender = genderData[genderPicker.selectedRow(inComponent: 0)]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return birthYearData.count
        }
        return genderData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return birthYearData[row]
        }
        return genderData[row]
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

// MARK: - TextFieldDelegate
extension PersonDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
