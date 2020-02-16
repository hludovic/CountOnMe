//
//  Calculator.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 14/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum Operator {
    case plus, minus, divide, multiply
}

class Calculator {
    var display: String
    
    init() {
        self.display = ""
    }
    
    var elements: [String] {
        return display.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {
        let firstElementsPM = elements.first != "+" && elements.first != "-"
        let lastElementsPM = elements.last != "+" && elements.last != "-"
        let firstElementsMD = elements.first != "*" && elements.first != "/"
        let lastElementsMD = elements.last != "*" && elements.last != "/"

        let first = firstElementsPM && firstElementsMD
        let last = lastElementsPM && lastElementsMD
        
        return first && last
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return display.firstIndex(of: "=") != nil
    }
    
    func calculateResult() {
        
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "*": result = left * right
                case "/": result = left / right
                default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        display.append(" = \(operationsToReduce.first!)")
    }
    
    
}
