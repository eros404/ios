//
//  PersonTVCTableViewController.swift
//  PersonMgr
//
//  Created by Utilisateur invité on 01/06/2022.
//

import UIKit

class PersonTVC: UITableViewController {
    
    var persons: [Person] = []

    @IBAction func didTapSort(_ sender: Any) {
        //create the ActionSheet with a title
        let newsActionSheet = UIAlertController(title: "Sort", message: nil, preferredStyle: .actionSheet)
        //create the sort button and the closure that is going to get executed when the user clicks
        let byFirstName = UIAlertAction(title: "by firstname", style: .default) { ( action: UIAlertAction) in
            self.persons.sort { $1.firstName > $0.firstName }
            self.tableView.reloadData()
        }
        let byLastName = UIAlertAction(title: "by lastname", style: .default) { ( action: UIAlertAction) in
            self.persons.sort { $1.lastName > $0.lastName }
            self.tableView.reloadData()
        }
        let byBirthYear = UIAlertAction(title: "by birth year", style: .default) { ( action: UIAlertAction) in
            self.persons.sort { $1.birthYear > $0.birthYear }
            self.tableView.reloadData()
        }
        //create a cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        //Add the 2 actions
        newsActionSheet.addAction(byFirstName)
        newsActionSheet.addAction(byLastName)
        newsActionSheet.addAction(byBirthYear)
        newsActionSheet.addAction(cancelAction)
        //Display the actionSheet in the current view
        self.present(newsActionSheet, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        for _ in 1...20 {
            persons.append(Person())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let person = persons[indexPath.item]
        cell.textLabel?.text = "\(person.firstName) \(person.lastName)"
        let currentYear: Int = Calendar.current.component(.year, from: Date())
        cell.detailTextLabel?.text = "\(person.gender) - \(currentYear - person.birthYear) years old"
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            persons.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            guard let detailVC = segue.destination as? PersonDetailVC else {
                return
            }
            //1st: get your person from your array based on your indexPath
            //2nd: give this person to your personDetailVC
            detailVC.person = persons[indexPath.item]
        }
    }

}
