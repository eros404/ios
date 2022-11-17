//
//  ViewController.swift
//  EightBall
//
//  Created by Utilisateur invité on 17/11/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let possibleAnswers = [ Answer(type: AnswerType.affirmative, text: "It is certain."), Answer(type: AnswerType.affirmative, text: "It is decidedly so."), Answer(type: AnswerType.affirmative, text: "Without a doubt."), Answer(type: AnswerType.affirmative, text: "Yes definitely."), Answer(type: AnswerType.affirmative, text: "You may rely on it."), Answer(type: AnswerType.affirmative, text: "As I see it, yes."), Answer(type: AnswerType.affirmative, text: "Most likely."), Answer(type: AnswerType.affirmative, text: "Outlook good."), Answer(type: AnswerType.affirmative, text: "Yes."), Answer(type: AnswerType.affirmative, text: "Signs point to yes."), Answer(type: AnswerType.unsure, text: "Reply hazy, try again."), Answer(type: AnswerType.unsure, text: "Ask again later."), Answer(type: AnswerType.unsure, text: "Better not tell you now."), Answer(type: AnswerType.unsure, text: "Cannot predict now."), Answer(type: AnswerType.unsure, text: "Concentrate and ask again."), Answer(type: AnswerType.negative, text: "Don't count on it."), Answer(type: AnswerType.negative, text: "My reply is no."), Answer(type: AnswerType.negative, text: "My sources say no."), Answer(type: AnswerType.negative, text: "Outlook not so good."), Answer(type: AnswerType.negative, text: "Very doubtful.") ]

    @IBOutlet weak var answerLabel: UILabel!
    @IBAction func checkButtonAction(_ sender: Any) {
        var max: Int = possibleAnswers.count - 1
        var answer = possibleAnswers[Int.random(in: 0...max)]
        answerLabel.text = answer.text
        switch (answer.type) {
        case AnswerType.affirmative:
            answerLabel.backgroundColor = UIColor.green
            break
        case AnswerType.unsure:
            answerLabel.backgroundColor = UIColor.orange
            break
        case AnswerType.negative:
            answerLabel.backgroundColor = UIColor.red
        }
    }
    
}

