//
//  DecimalExtension.swift
//  tmdb
//
//  Created by Guest User on 13/12/2022.
//

import Foundation

extension Decimal {
    func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
