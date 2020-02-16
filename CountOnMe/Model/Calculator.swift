//
//  Calculator.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 14/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    var display: String
    
    init() {
        self.display = ""
    }
    
    var elements: [String] {
        return display.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {
        let firstElements = elements.first != "+" && elements.first != "-"
        let lastElements = elements.last != "+" && elements.last != "-"
        return firstElements && lastElements
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
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        display.append(" = \(operationsToReduce.first!)")
    }
    
    
}
