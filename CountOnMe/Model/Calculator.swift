//
//  Calculator.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 14/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation


protocol DisplayDelegate {
    func displayText(_ text: String)
    func displayError(_ text: String)
}


class Calculator {
    
    var delegate: DisplayDelegate?
    
    private var textString: String = "" {
        didSet {
            delegate?.displayText(textString)
        }
    }
    
    private var errorMessage = "" {
        didSet {
            delegate?.displayError(errorMessage)
        }
    }
    
    var elements: [String] {
        return textString.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textString.firstIndex(of: "=") != nil
    }
        
    
    func tappedNumber(number: String) {
        if expressionHaveResult {
            textString = ""
        }
        
        textString.append(number)
    }
    
    func tappedAddition() {
        if canAddOperator {
            textString.append(" + ")
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }
    
    func tappedSubstraction() {
        if canAddOperator {
            textString.append(" - ")
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }

    func tappedEqual() {
        guard expressionIsCorrect else {
            errorMessage = "Entrez une expression correcte !"
            return
        }
        
        guard expressionHaveEnoughElement else {
            errorMessage = "Démarrez un nouveau calcul !"
            return
        }
        
        // Create local copy of operations
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
        
        textString.append(" = \(operationsToReduce.first!)")
    }

    
    
}
