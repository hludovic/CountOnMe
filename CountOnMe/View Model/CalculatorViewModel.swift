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

/// Lists all kind of operations that can be performed with a Calculator.
enum Operator: String {
    case plus = "+", minus = "-", divide = "÷", multiply = "×"
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
        self.textDisplay = calculator.operation
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
        if calculator.operation == "" || calculator.expressionHaveResult {
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
                textDisplay.append(" ÷ ")
            case .multiply:
                textDisplay.append(" × ")
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

        guard calculator.canAddOperator else {
            errorMessage = "Entrez un chiffre !"
            return
        }

        calculateResult()
        textDisplay = calculator.operation
    }

    func calculateResult() {
        var operationsToReduce = calculator.elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else { return errorMessage = "Calcul Impossible" }
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else { return errorMessage = "Calcul Impossible" }

            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            default: return errorMessage = "Opérateur inconnu"
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(formatResult(result), at: 0)
        }

        calculator.operation.append(" = \(operationsToReduce.first!)")
    }

    private func formatResult(_ result: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 3
        if let numberFormatted = numberFormatter.string(from: NSNumber(value: result)) {
            return numberFormatted
        } else { return "" }
    }

}
