//
//  Question.swift
//  06-04_Cons_Edutainment
//
//  Created by Vladislav on 24.09.2026.
//

import Foundation

struct Question {
    let multiplicand: Int
    let multiplier: Int
    
    var product: Int {
        multiplicand * multiplier
    }
    
    var condition: String {
        "\(multiplicand) x \(multiplier) ="
    }
    
    var answer: String {
        "\(product)"
    }
}
