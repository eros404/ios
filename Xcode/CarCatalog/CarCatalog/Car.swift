//
//  Car.swift
//  CarCatalog
//
//  Created by Utilisateur invité on 31/05/2022.
//

import Foundation

class Car {
    var model: String
    var maker: String
    var price: Int
    init(model: String, maker: String, price: Int) {
        self.model = model
        self.maker = maker
        self.price = price
    }
    var description: String {
        return "\(self.model) \(self.maker) \(self.price)"
    }
    static func makeRandomCar() -> Car {
        return Car(model: "model \(Int.random(in: 1...100))", maker: "maker \(Int.random(in: 1...100))", price: Int.random(in: 2000...10000))
    }
}
