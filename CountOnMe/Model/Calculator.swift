//
//  Calculator.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 14/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

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
        let firstPM = elements.first != "+" && elements.first != "-"
        let firstMD = elements.first != "×" && elements.first != "÷"

        return firstMD && firstPM
    }

    /// Returns whether this operation has enough elements for it to be calculated.
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    /// Returns whether an operator can be added to this operation.
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "×"
    }

    /// Returns whether this operation has already been calculated.
    var expressionHaveResult: Bool {
        return operation.firstIndex(of: "=") != nil
    }
}
