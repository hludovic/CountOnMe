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
    func displayOperation(_ text: String)
    func displayError(_ text: String)
}

/// This class tests and performs operations, and delegates the display of its results.
class CalculatorViewModel {
    private var calculator: Calculator
    weak var delegate: DisplayDelegate?

    /// The class conforming to the "DisplayDelegate" protocol will receive all updates of the operation.
    private(set) var textDisplay: String {
        didSet {
            calculator.operation = textDisplay
            delegate?.displayOperation(textDisplay)
        }
    }

    /// The class conforming to the "DisplayDelegate" protocol will be able to receive error messages.
    private(set) var errorMessage: String = "" {
        didSet {
            delegate?.displayError(errorMessage)
        }
    }

    init(calculator: Calculator = .init()) {
        self.calculator = calculator
        self.textDisplay = ""
    }

    /// This method tests whether a new number can be added to the operation,
    /// and then refreshes the operation in "textString" by adding this number if possible.
    /// - Parameter number: The number in String format that can be added with this method.
    func tappeNumber(number: String) {
        if calculator.expressionHaveResult {
            textDisplay = ""
        }
        textDisplay.append(number)
    }

    /// This method tests if an operator can be added to the operation,
    /// then refreshes the operation in "textString" by adding this operator if possible.
    /// - Parameter button: The types of operations that can be performed with this method
    func tappeOperator(button: Operator) {
        if calculator.operation == "" {
            errorMessage = "Entrez d'abord un chiffre !"
            return
        }

        if calculator.expressionHaveResult {
            errorMessage = "Entrez d'abord un chiffre !"
            return
        }

        if calculator.canAddOperator {
            switch button {
            case .plus:
                textDisplay.append(" + ")
            case .minus:
                textDisplay.append(" - ")
            case .divide:
                textDisplay.append(" / ")
            case .multiply:
                textDisplay.append(" * ")
            }
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }

    /// This method tests whether the operation can be solved,
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
        textDisplay = calculator.operation
    }
}
