//
//  CalculatorViewModel.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 15/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// Any class complying with this protocol will be delegated the tasks of displaying the operation and error messages.
protocol DisplayDelegate: AnyObject {
    func displayText(_ text: String)
    func displayError(_ text: String)
}

/// This class tests and performs operations, and delegates the display of its results.
class CalculatorViewModel {
    private var calculator: Calculator
    weak var delegate: DisplayDelegate?

    /// The class conforming to the "DisplayDelegate" protocol will receive all updates of the operation.
    private(set) var operation: String {
        didSet {
            calculator.display = operation
            delegate?.displayText(operation)
        }
    }

    /// The class conforming to the "DisplayDelegate" protocol will be able to receive error messages.
    private(set) var errorMessage: String = "" {
        didSet {
            delegate?.displayError(errorMessage)
        }
    }

    init(calculator: Calculator) {
        self.calculator = calculator
        self.operation = ""
    }

    /// This function tests whether a new number can be added to the operation,
    /// and then refreshes the operation in "textString" by adding this number if possible.
    /// - Parameter number: The number in String format that can be added with this function.
    func tappeNumber(number: String) {
        if calculator.expressionHaveResult {
            operation = ""
        }
        operation.append(number)
    }

    /// This function tests if an operator can be added to the operation,
    /// then refreshes the operation in "textString" by adding this operator if possible.
    /// - Parameter button: The types of operations that can be performed with this function
    func tappeOperator(button: Operator) {
        if calculator.display == "" {
            errorMessage = "Entrez d'abord un chiffre"
            return
        }

        if calculator.expressionHaveResult {
            errorMessage = "Le calcul est déjà terminé !"
            return
        }

        if calculator.canAddOperator {
            switch button {
            case .plus:
                operation.append(" + ")
            case .minus:
                operation.append(" - ")
            case .divide:
                operation.append(" / ")
            case .multiply:
                operation.append(" * ")
            }
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }

    /// This function tests whether the operation can be solved,
    /// and updates the result in "textString" if it has been solved.
    func tappeEqual() {
        guard !calculator.expressionHaveResult else {
            errorMessage = "Le calcul est déjà terminé !"
            return
        }

        guard calculator.expressionIsCorrect else {
            errorMessage = "Entrez une expression correcte !"
            return
        }

        guard calculator.expressionHaveEnoughElement else {
            errorMessage = "Démarrez un nouveau calcul !"
            return
        }

        calculator.calculateResult()
        operation = calculator.display
    }
}
