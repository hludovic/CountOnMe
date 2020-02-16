//
//  CalculatorViewModel.swift
//  CountOnMe
//
//  Created by Ludovic HENRY on 15/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol DisplayDelegate {
    func displayText(_ text: String)
    func displayError(_ text: String)
}

class CalculatorViewModel {
    private var calculator: Calculator
    var delegate: DisplayDelegate?
        
    private(set) var textString: String {
        didSet {
            calculator.display = textString
            delegate?.displayText(textString)
        }
    }
    
    private(set) var errorMessage: String = "" {
        didSet {
            delegate?.displayError(errorMessage)
        }
    }

    init(calculator: Calculator) {
        self.calculator = calculator
        self.textString = ""
    }
    
    // TODO: 
    func tappedNumber(number: String) {
        if calculator.expressionHaveResult {
            textString = ""
        }
        textString.append(number)
    }
        
    func tappeOperatorButton(button: Operator) {
        if calculator.expressionHaveResult {
            errorMessage = "Le calcul est déjà terminé !"
            return
        }
        
        if calculator.canAddOperator {
            switch button {
            case .plus:
                textString.append(" + ")
            case .minus:
                textString.append(" - ")
            case .divide:
                textString.append(" / ")
            case .multiply:
                textString.append(" * ")
            }
        } else {
            errorMessage = "Un operateur est déja mis !"
        }
    }
    
    // TODO: Add a function tappedDivid and multiply

    func tappedequal() {
        
        if calculator.expressionHaveResult {
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
        textString = calculator.display
        
    }

    
}
