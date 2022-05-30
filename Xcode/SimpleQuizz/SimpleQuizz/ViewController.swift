//
//  ViewController.swift
//  SimpleQuizz
//
//  Created by Utilisateur invité on 30/05/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelAnswer: UILabel!
    @IBAction func showQuestion(_ sender: Any) {
        currentQuestionIndex = currentQuestionIndex > questions.count - 1 ? 0 : currentQuestionIndex + 1
        self.labelQuestion.text = questions[currentQuestionIndex]
        self.labelAnswer.text = "???"
    }
    @IBAction func showAnswer(_ sender: Any) {
        self.labelAnswer.text = answers[currentQuestionIndex]
    }
    
    var currentQuestionIndex = -1
    let questions = ["What is 7 + 7?", "What is the capital of France?", "From what is cognac made off?", "Miroir, miroir, qui est la plus belle ?"]
    let answers = ["14", "Paris", "Grapes", "C'est Valou."]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

