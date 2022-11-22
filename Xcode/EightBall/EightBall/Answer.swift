//
//  Answer.swift
//  EightBall
//
//  Created by Utilisateur invité on 17/11/2022.
//

import Foundation

enum AnswerType : String {
    case affirmative
    case unsure
    case negative
}

class Answer {
    var type: AnswerType
    var text: String
    init(type: AnswerType, text: String) {
        self.type = type
        self.text = text
    }
}
