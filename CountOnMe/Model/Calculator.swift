//
//  Calculator.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 14/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// Lists all kind of operations that can be performed with a Calculator.
enum Operator {
    case plus, minus, divide, multiply
}

class Calculator {
    /// This property contains the operation that can be calculated.
    var operation: String

    init() {
        self.operation = ""
    }

    /// Returns an array containing all the elements of this operation, and without spaces.
    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    /// Tests if this operation does not have an operator as first or last element.
    var expressionIsCorrect: Bool {
        let firstElementsPM = elements.first != "+" && elements.first != "-"
        let lastElementsPM = elements.last != "+" && elements.last != "-"
        let firstElementsMD = elements.first != "*" && elements.first != "/"
        let lastElementsMD = elements.last != "*" && elements.last != "/"

        let first = firstElementsPM && firstElementsMD
        let last = lastElementsPM && lastElementsMD

        return first && last
    }

    /// Returns whether this operation has enough elements for it to be calculated.
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    /// Returns whether an operator can be added to this operation.
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    /// Returns whether this operation has already been calculated.
    var expressionHaveResult: Bool {
        return operation.firstIndex(of: "=") != nil
    }

    /// Resolves the operation in the property "display" and updates it with a result.
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
        operation.append(" = \(operationsToReduce.first!)")
    }
}
