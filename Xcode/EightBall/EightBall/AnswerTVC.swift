//
//  AnswerTVC.swift
//  EightBall
//
//  Created by Guest User on 22/11/2022.
//

import UIKit

class AnswerTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    var groupedAnswers: [AnswerType : [Answer]] = [:]
    var allAnswerTypes: [AnswerType] = []

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return allAnswerTypes.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupedAnswers[allAnswerTypes[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCellId", for: indexPath)
        let answer = groupedAnswers[allAnswerTypes[indexPath.section]]?[indexPath.item]
        if let answer = answer {
            var content = cell.defaultContentConfiguration()
            content.text = answer.text
            cell.contentConfiguration = content
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allAnswerTypes[section].rawValue
    }

}
