//
//  Person.swift
//  PersonMgr
//
//  Created by Utilisateur invité on 02/06/2022.
//

import Foundation

class Person {
    var firstName: String
    var lastName: String
    var birthYear: Int
    var nationality: String
    var gender: String
    
    init() {
        firstName = "John \(Int.random(in: 1...1000))"
        lastName = "Doe"
        birthYear = Int.random(in: 1950...2022)
        nationality = "American"
        gender = "Male"
    }
}
